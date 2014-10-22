Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:52779 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751786AbaJVNzO (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 22 Oct 2014 09:55:14 -0400
Date: Wed, 22 Oct 2014 15:55:10 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Jason Cooper <jason@lakedaemon.net>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wim Van Sebroeck <wim@iguana.be>,
	<linux-watchdog@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	Nadav Haklai <nadavh@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>
Subject: Re: [PATCH 4/4] ARM: dts: Enable the reference clock for timer and
 watchdog on Armada 375 SoC
Message-ID: <20141022155510.5fee5f8e@free-electrons.com>
In-Reply-To: <1413984884-20273-5-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1413984884-20273-1-git-send-email-ezequiel.garcia@free-electrons.com>
	<1413984884-20273-5-git-send-email-ezequiel.garcia@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Dear Ezequiel Garcia,

On Wed, 22 Oct 2014 10:34:44 -0300, Ezequiel Garcia wrote:

> -				clocks = <&coreclk 0>;
> +				clocks = <&refclk>;
> +				clock-names = "fixed";

Why not do like we do on Armada XP, and actually represent the
hardware, by showing that it takes two clocks as input:

                        timer@20300 {
                                compatible = "marvell,armada-xp-timer";
                                clocks = <&coreclk 2>, <&refclk>;
                                clock-names = "nbclk", "fixed";
                        };



>  			watchdog@20300 {
>  				compatible = "marvell,armada-375-wdt";
>  				reg = <0x20300 0x34>, <0x20704 0x4>, <0x18254 0x4>;
> -				clocks = <&coreclk 0>;
> +				clocks = <&refclk>;
> +				clock-names = "fixed";
>  			};

Ditto.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
