Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:36249 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932152AbbKXWnp (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 24 Nov 2015 17:43:45 -0500
Message-ID: <5654E7DE.4020400@gmail.com>
Date: Tue, 24 Nov 2015 14:42:38 -0800
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
Subject: Re: [PATCH (v2) 6/10] watchdog: bcm63xx_wdt: Obtain watchdog clock
 HZ from "periph" clk
References: <5650BFD6.5030700@simon.arlott.org.uk>    <5650C08C.6090300@simon.arlott.org.uk> <5650E2FA.6090408@roeck-us.net>    <5650E5BB.6020404@simon.arlott.org.uk> <56512937.6030903@roeck-us.net>    <5651CB13.4090704@simon.arlott.org.uk>    <5651CC3C.5090200@simon.arlott.org.uk> <38e0094262a1f609b95697730137fb81dc83fcea@8b5064a13e22126c1b9329f0dc35b8915774b7c3.invalid>
In-Reply-To: <38e0094262a1f609b95697730137fb81dc83fcea@8b5064a13e22126c1b9329f0dc35b8915774b7c3.invalid>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 24/11/15 14:12, Simon Arlott wrote:
> Instead of using a fixed clock HZ in the driver, obtain it from the
> "periph" clk that the watchdog timer uses.
> 
> Signed-off-by: Simon Arlott <simon@fire.lp0.eu>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
