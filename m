Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:35251 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752160AbbFAPKB (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 1 Jun 2015 11:10:01 -0400
MIME-Version: 1.0
From: Valentin Rothberg <valentinrothberg@gmail.com>
Date: Mon, 1 Jun 2015 17:09:29 +0200
Message-ID: <CAD3Xx4JLanN3Luo1ijtPAA5LKz8fiWU=zs2SuCGvGn6JTMka_Q@mail.gmail.com>
Subject: watchdog: st_wdt: select on undefined MFD_ST_LPC
To: lee.jones@linaro.org
Cc: Valentin Rothberg <valentinrothberg@gmail.com>,
	Andreas Ruprecht <andreas.ruprecht@fau.de>,
	Paul Bolle <pebolle@tiscali.nl>,
	hengelein Stefan <stefan.hengelein@fau.de>, wim@iguana.be,
	david.paris@st.com, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Lee,

your commit d0c9e350b9a4 ("watchdog: st_wdt: Add new driver for ST's
LPC Watchdog") is in today's linux-next tree (i.e., next-20150601) and
adds the following lines of code to drivers/watchdog/Kconfig.

+config ST_LPC_WATCHDOG
...
+       select MFD_ST_LPC

The select turns out to be a NOOP since MFD_ST_LPC is not defined
Kconfig.  Is it the correct option to be selected?  I could not find a
similar option in the source, nor get any hints  from searching the
lkml.

I detected the issue with ./scripts/checkkconfigsymbols.py by diffing
the last and today's linux tree.

Kind regards,
 Valentin
