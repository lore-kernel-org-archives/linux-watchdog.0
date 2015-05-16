Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:46621 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S2992541AbbEPAqh (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 15 May 2015 20:46:37 -0400
Date: Sat, 16 May 2015 02:46:34 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: S Twiss <stwiss.opensource@diasemi.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	DEVICETREE <devicetree@vger.kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	LINUXINPUT <linux-input@vger.kernel.org>,
	LINUXKERNEL <linux-kernel@vger.kernel.org>,
	LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
	Lee Jones <lee.jones@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Pawel Moll <pawel.moll@arm.com>,
	RTCLINUX <rtc-linux@googlegroups.com>,
	Rob Herring <robh+dt@kernel.org>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	David Dajun Chen <david.chen@diasemi.com>,
	Support Opensource <support.opensource@diasemi.com>
Subject: Re: [rtc-linux] [PATCH V2 0/4]  da9062: DA9062 driver submission
Message-ID: <20150516004634.GH3338@piout.net>
References: <cover.1431621833.git.stwiss.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1431621833.git.stwiss.opensource@diasemi.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi,

On 14/05/2015 at 17:43:53 +0100, S Twiss wrote :
> From: S Twiss <stwiss.opensource@diasemi.com>
> 
> This patch set adds support for the Dialog DA9062 Power Management IC.
> 
> In this patch set the following is provided:
>  - [PATCH V2 1/4]: MFD core support  
>  - [PATCH V2 2/4]: BUCK and LDO regulator driver
>  - [PATCH V2 3/4]: Watchdog driver
>  - [PATCH V2 4/4]: Add bindings for all DA9062 components

This patch should actually be the first one to go in, else checkpatch
will complain about compatibles not being found.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
