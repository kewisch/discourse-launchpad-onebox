# frozen_string_literal: true

# name: discourse-launchpad-onebox
# about: Onebox plugin to show launchpad group members
# version: 1.0.0
# authors: Philipp Kewisch (@kewisch)
# url: https://github.com/kewisch/discourse-launchpad-onebox

require_relative '../../lib/onebox'

class Onebox::Engine::LaunchpadMemberOnebox
  include Onebox::Engine

  REGEX = %r{^https://launchpad.net/~(?<group>[a-z][a-z0-9-]*)/\+members$}

  matches_regexp(REGEX)
  always_https

  def match
    @match ||= @url.match(REGEX)
  end

  def to_html
    html = <<~HTML
      <aside class="onebox allowlistedgeneric" data-onebox-src="#{@url}">
        <header class="source">
          <img class="site-icon" src="https://launchpad.net/@@/favicon-32x32.png?v=2022">
          <a href="#{group_raw['web_link']}" target="_blank" rel="nofollow ugc noopener" tabindex="-1">Launchpad</a>
        </header>
        <article class="onebox-body">
          <h3>#{group_raw['display_name']}</h3>
          <p>
            <ul>
    HTML

    raw['entries'].each do |item|
      html += "\n<li><a href='#{item['web_link']}'>#{item['display_name']}</a></li>"
    end

    html += <<~HTML
            </ul>
          </p>
        </article>
      </aside>
    HTML

    html
  end

  def data
    raw['entries'].clone
  end

  def raw
    members_url = "https://api.launchpad.net/devel/~#{match[:group]}/members"
    @raw ||= ::MultiJson.load(URI.parse(members_url).open(read_timeout: timeout))
  end
  def group_raw
    group_url = "https://api.launchpad.net/devel/~#{match[:group]}"
    @group_raw ||= ::MultiJson.load(URI.parse(group_url).open(read_timeout: timeout))
  end
end
