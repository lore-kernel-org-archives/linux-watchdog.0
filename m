Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from cpsmtpb-ews03.kpnxchange.com ([213.75.39.6]:63206 "EHLO
	cpsmtpb-ews03.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753818AbbBDKNc (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 4 Feb 2015 05:13:32 -0500
Message-ID: <1423044809.23894.65.camel@x220>
Subject: watchdog: SOC_MT7621?
From: Paul Bolle <pebolle@tiscali.nl>
To: Wim Van Sebroeck <wim@iguana.be>,
	Ralf Baechle <ralf@linux-mips.org>
Cc: Valentin Rothberg <valentinrothberg@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Date: Wed, 04 Feb 2015 11:13:29 +0100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

John Crispin's commit 576c618cf659 ("watchdog: add MT7621 watchdog
support") was included in today's linux-next (ie, next 20150204). I
noticed because a script I use to check linux-next spotted a problem
with it.

That commit adds an (optional) dependency on the Kconfig symbol
SOC_MT7621. But there's no symbol SOC_MT7621 in linux-next yet.

(Note that there currently are two checks for CONFIG_SOC_MT7621 in
arch/mips/ralink/early_printk.c. I mentioned these checks in
https://lkml.org/lkml/2014/10/27/218 and in
https://lkml.org/lkml/2015/1/12/302 . John never replied to these
messages. Since I haven't received replies on other, more serious issues
in over three months I assume John has disappeared.)

Is SOC_MT7621 still being worked on?


Paul Bolle

