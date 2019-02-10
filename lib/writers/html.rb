require_relative './base'

module Writers
  class Html < Base
    STYLES =
      'body { font-size: 12px; font-family: Arial; }' \
      'td, th { padding: 8px; }' \
      'td { background: #002b36; color: #839496; }' \
      'th { background: #073642; color: #2aa198; }'

    def append(row = [])
      if thead_list.length == 0
        thead_list.push as_thead(row)
      else
        tbody_list.push as_tr(row)
      end
    end

    def save
      File.open(complete_filename, 'w+') do |f|
        f.write(html)
      end
    end

    private

    def as_thead(row = [])
      th_list = row.map { |data| "<th>#{data}</th>" }.join
      "<thead>#{th_list}</thead>"
    end

    def as_tr(row = [])
      td_list = row.map { |data| "<td>#{data}</td>" }.join
      "<tr>#{td_list}</tr>"
    end

    def html
      "<html>#{head}#{body}</html>"
    end

    def head
      "<head>#{styles}</head>"
    end

    def body
      "<body>#{table}</body>"
    end

    def table
      "<table>#{thead}#{tbody}</table>"
    end

    def thead
      "<thead>#{thead_list.join}</thead>"
    end

    def tbody
      "<tbody>#{tbody_list.join}</tbody>"
    end

    def styles
      "<style>#{STYLES}</style>"
    end

    def thead_list
      @thead ||= []
    end

    def tbody_list
      @tbody ||= []
    end

    def file_extension
      'html'
    end
  end
end
