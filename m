Return-Path: <marek.behun@nic.cz>
Return-path: <marek.behun@nic.cz>
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
To: linux-watchdog@vger.kernel.org
Cc: wim@linux-watchdog.org,
	Guenter Roeck <linux@roeck-us.net>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH v3 0/4] Add support for Armada 37xx CPU watchdog
Date: Fri,  7 Sep 2018 15:05:49 +0200
Message-Id: <20180907130553.14271-1-marek.behun@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>

Hello.

This is a resend of v2 patch series, which didn't include explanation of
changes from previous version nor proper Cc to devicetree maintainers.

Changes from previous version (v1)
  - devicetree binding and documentation is in a separate patch
  - watchdog pinging is done differently. In previous version only
    one counter (ID 1) was used to implement watchdog, and this counter
    had to be restarted when pinging, leaving the system in a vulnerable
    state for a brief period of time.
    Now pinging is done by forcing immediate expiration event on counter
    ID 0, and counter ID 1 is set to restart counting from the initial value
    when this event happens. Thus counter ID 1, which is set to be watchdog
    counter, is never disabled, and the system is never in this brief
    vulnerable state
  - reading current value of the counter now reads low 32 bits first, because
    when this is done, the hardware puts the high 32 bits in flip-flops so as
    to avoid software debouncing. This way get_counter_value always returns
    correct result

Marek
