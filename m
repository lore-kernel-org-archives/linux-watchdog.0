Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34704 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932109AbbKXWoi (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 24 Nov 2015 17:44:38 -0500
Message-ID: <5654E814.6030807@gmail.com>
Date: Tue, 24 Nov 2015 14:43:32 -0800
From: Florian Fainelli <f.fainelli@gmail.com>
MIME-Version: 1.0
To: Simon Arlott <simon@fire.lp0.eu>, linux-watchdog@vger.kernel.org
CC: Guenter Roeck <linux@roeck-us.net>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Kevin Cernekee <cernekee@gmail.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Maxime Bizon <mbizon@freebox.fr>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-mips@linux-mips.org, Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Jonas Gorski <jogo@openwrt.org>
Subject: Re: [PATCH (v2) 7/10] watchdog: bcm63xx_wdt: Add get_timeleft function
References: <5650BFD6.5030700@simon.arlott.org.uk>    <5650C08C.6090300@simon.arlott.org.uk> <5650E2FA.6090408@roeck-us.net>    <5650E5BB.6020404@simon.arlott.org.uk> <56512937.6030903@roeck-us.net>    <5651CB13.4090704@simon.arlott.org.uk>    <5651CC90.7090402@simon.arlott.org.uk> <a1461a17c94353f38316d2c6ae04d6b77c91bfd4@8b5064a13e22126c1b9329f0dc35b8915774b7c3.invalid>
In-Reply-To: <a1461a17c94353f38316d2c6ae04d6b77c91bfd4@8b5064a13e22126c1b9329f0dc35b8915774b7c3.invalid>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 24/11/15 14:15, Simon Arlott wrote:
> Return the remaining time from the hardware control register.
> 
> Warn when the device is registered if the hardware watchdog is currently
> running and report the remaining time left.
> 
> Signed-off-by: Simon Arlott <simon@fire.lp0.eu>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

At some point, we should probably consider merging bcm63xx_wdt with
bcm7038_wdt which are nearly 100% identical pieces of hardware (coming
from the same design group originally).
-- 
Florian
