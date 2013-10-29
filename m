Return-Path: <wimvs@spo001.leaseweb.com>
Date: Tue, 29 Oct 2013 08:58:08 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: dinguyen@altera.com
Cc: dinh.linux@gmail.com, Guenter Roeck <linux@roeck-us.net>,
	Viresh Kumar <viresh.linux@gmail.com>,
	Rob Herring <rob.herring@calxeda.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCHv6] watchdog: dw: Enable OF support for DW watchdog timer
Message-ID: <20131029075808.GI19704@spo001.leaseweb.com>
References: <1382461152-22891-1-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1382461152-22891-1-git-send-email-dinguyen@altera.com>
Sender: <wimvs@spo001.leaseweb.com>
List-ID: <linux-watchdog@vger.kernel.org>

Hi Dinh,

> From: Dinh Nguyen <dinguyen@altera.com>
> 
> Add device tree support to the DW watchdog timer.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> Acked-by: Jamie Iles <jamie@jamieiles.com>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Reviewed-by: Pavel Machek <pavel@denx.de>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Viresh Kumar <viresh.linux@gmail.com>
> Cc: Wim Van Sebroeck <wim@iguana.be>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> Cc: devicetree@vger.kernel.org
> Cc: linux-watchdog@vger.kernel.org

Patch has been added to linux-watchdog-next.
I also added a #ifdef CONFIG_OF to the patch.
Reason: either we us the ifdef around the MODULE_DEVICE_TABLE together with the of_match_ptr
or we us no ifdef but then also no of_match_ptr. See also Sachin Kamat's patch (watchdog: Remove redundant of_match_ptr).

Kind regards,
Wim.
