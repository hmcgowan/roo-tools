module RooTools
  
  class Grep
    @@matches = 0
    @@matching_files = 0
    FilenameFormat = "%-76s"
    MatchFormat = "%-31s %-8s %-35s "
    def matches
      @@matches
    end
    def matching_files
      @@matching_files
    end

    def initialize(opts)
      @options = opts
      @regex = create_regular_expression
      @seen = {}
    end

    def process_files
      @options[:files].each do |file|
        if File.directory?(file)
          Dir.glob(File.join(file.gsub('\\','/'),"**","*.xls")).each do |file|
            execute(file)
          end
        else
          execute(file)
        end
      end    
    end

    def execute(file)
      @file = file
      @oo = open_spreadsheet(@file)
      @oo.sheets.each do |sheet|
        @oo.default_sheet = sheet
        check_sheet_name 
        check_sheet_contents
        return if @options[:list_only] && @seen[@file] 
      end
    end

    def open_spreadsheet(filename)
      case File.extname(filename)
      when '.xls'
        Excel.new(filename)
      when '.xlsx'
        Excelx.new(filename)
      when '.ods'
        Openoffice.new(filename)
      when ''
        Google.new(filename)
      else
        raise ArgumentError, "Don't know how to handle spreadsheet #{filename}"
      end
    end
  
    def check_sheet_name
      return unless @options[:tabs]
      return unless @options[:font] == 'normal' || @options[:font] == 'ignore'
      if @oo.default_sheet =~ @regex
        report_match 
      end
    end

    def check_sheet_contents
      return unless @options[:cells]
      return unless @oo.last_row && @oo.last_column
      (1..@oo.last_row).each do |row|
         (1..@oo.last_column).each do |col|
           cell = @oo.cell(row,col)
           cellname = GenericSpreadsheet.number_to_letter(col) + row.to_s
           if cell =~ @regex
             case @options[:font]
             when 'ignore'
                report_match cell, cellname
             when 'normal'
               if !@oo.font(row,col).bold? && !@oo.font(row,col).bold? && !@oo.font(row,col).italic?
                 report_match cell, cellname
               end
             else
               if @oo.font(row,col).send "#{@options[:font]}?"
                 report_match cell, cellname
               end
             end
             return if @options[:list_only] && @seen[@file]
           end
         end
      end
    end

    def report_match(desc=nil, cellname=nil )
      if desc && desc.length >= 35
        desc = desc[0..32] + '...'
      end
      unless @seen[@file] 
        puts "\n" unless @options[:list_only]
        puts sprintf(FilenameFormat, @file[0..74]) 
        @seen[@file] = true
        @@matching_files += 1
      end
      @@matches +=1
      unless @options[:list_only]
        if cellname
          # This is a matching tab
          puts sprintf(MatchFormat, @oo.default_sheet, cellname, desc)
        else
          # This is a matching tab
          puts sprintf(MatchFormat, @oo.default_sheet, 'tabname', nil)
        end
      end
    end

    def create_regular_expression
      str = @options[:searchstring]
      if @options[:exact_match]
        str = "\\s*\\A#{Regexp.escape(str)}\\Z\\s*"
      end
      if @options[:case_insensitive]
        /#{str}/i
      else
        /#{str}/
      end
    end


  end
end  