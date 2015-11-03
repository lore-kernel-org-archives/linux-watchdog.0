Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:53981 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016AbbKCImF (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 3 Nov 2015 03:42:05 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Lee Jones <lee.jones@linaro.org>
Cc: Damien Riegel <damien.riegel@savoirfairelinux.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, shawnguo@kernel.org,
	kernel@pengutronix.de, wim@iguana.be, robh+dt@kernel.org,
	sameo@linux.intel.com, dinh.linux@gmail.com, linux@roeck-us.net,
	kernel@savoirfairelinux.com
Subject: Re: [PATCH v2 2/5] mfd: ts4800-syscon: add driver for TS-4800 syscon
Date: Tue, 03 Nov 2015 09:40:52 +0100
Message-ID: <4911273.Q2mbQ2gvpn@wuerfel>
In-Reply-To: <20151103083923.GD3503@x1>
References: <1446150450-22093-1-git-send-email-damien.riegel@savoirfairelinux.com> <20151103083817.GC3503@x1> <20151103083923.GD3503@x1>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tuesday 03 November 2015 08:39:23 Lee Jones wrote:
> On Tue, 03 Nov 2015, Lee Jones wrote:
> 
> > On Mon, 02 Nov 2015, Damien Riegel wrote:
> > > On Mon, Nov 02, 2015 at 09:12:53AM +0000, Lee Jones wrote:
> > > > [Cc'ing Arnd]
> > > > 
> > > > On Fri, 30 Oct 2015, Damien Riegel wrote:
> > > > > On Fri, Oct 30, 2015 at 05:56:56PM +0000, Lee Jones wrote:
> > > > > > On Thu, 29 Oct 2015, Damien Riegel wrote:
> > > > > > 
> > > > > > > Driver for TS-4800 syscon. These registers belong to a FPGA that is
> > > > > > > memory mapped and are used for counters, enable various IPs in the FPGA,
> > > > > > > control LEDs, control IOs, etc.
> > > > > > > 
> > > > > > > Currently, only the watchdog is handled.
> > > > > > 
> > > > > > Why do you require your own syscon driver?
> > > > > > 
> > > > > > What's wrong with the generic one?
> > > > > > 
> > > > > 
> > > > > The generic one uses a regmap_config with reg_stride set to 4 and val_bits
> > > > > to 32.
> > > > > 
> > > > > TS-4800 syscon registers are 16-bit wide and must be accessed with 16
> > > > > bit read and writes:
> > > > > http://wiki.embeddedarm.com/wiki/TS-4800#Syscon
> > > > > 
> > > > > I will address the other issues in the next version (split commit,
> > > > > license issue, style, and superfluous remove).
> > > > 
> > > > The Syscon driver was written to be generic so that each
> > > > vendor/platform didn't require their own incarnation.  How unique is
> > > > the TS-4800?
> > > > 
> > > > Perhaps it might be better to supply a generic 16 bit Syscon for
> > > > devices akin to the TS-4800?
> > > 
> > > The TS-4800 syscon could use a generic 16-bit syscon. There is nothing
> > > specific that requires a driver besides that.
> > > 
> > > We could add some optional properties to the generic syscon node to
> > > configure reg_bits, val_bits, and reg_stride (and pad_bits ?). Would
> > > that be a good solution ?
> > 
> > Without looking at the ramifications of such an addition, the premise
> > sounds good to me.  So long as the current behaviour remains the
> > default.
> 
> Perhaps a "syscon-16bit" compatible might be in order?
> 
> 

I think a 'buswidth=<16>;' property in addition to 'compatible="syscon"'
is more in line with what other subsystems do.

	Arnd
