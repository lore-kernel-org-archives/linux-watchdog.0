Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.savoirfairelinux.com ([208.88.110.44]:60133 "EHLO
	mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754008AbbKXQcd (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 24 Nov 2015 11:32:33 -0500
Date: Tue, 24 Nov 2015 11:24:39 -0500
From: Damien Riegel <damien.riegel@savoirfairelinux.com>
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, robh+dt@kernel.org,
	shawnguo@kernel.org, kernel@pengutronix.de, wim@iguana.be,
	sameo@linux.intel.com, dinh.linux@gmail.com, linux@roeck-us.net,
	Arnd Bergmann <arnd@arndb.de>, kernel@savoirfairelinux.com
Subject: Re: [PATCH v4 2/5] mfd: syscon: add a DT property to set value width
Message-ID: <20151124162439.GC4616@localhost>
References: <1448291861-28543-1-git-send-email-damien.riegel@savoirfairelinux.com>
 <1448291861-28543-3-git-send-email-damien.riegel@savoirfairelinux.com>
 <20151124082036.GE807@x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20151124082036.GE807@x1>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Nov 24, 2015 at 08:20:36AM +0000, Lee Jones wrote:
> On Mon, 23 Nov 2015, Damien Riegel wrote:
> 
> > Currently syscon has a fixed configuration of 32 bits for register and
> > values widths. In some cases, it would be desirable to be able to
> > customize the value width.
> > 
> > For example, certain boards (like the ones manufactured by Technologic
> > Systems) have a FPGA that is memory-mapped, but its registers are only
> > 16-bit wide.
> > 
> > This patch adds an optional "bus-width" DT binding for syscon that
> > allows to change the width for the data bus (i.e. val_bits). If this
> > property is provided, it will also adjust the register stride to
> > bus-width / 8. If not provided, the default configuration is used.
> > 
> > Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
> > ---
> >  Documentation/devicetree/bindings/mfd/syscon.txt |  3 +++
> >  drivers/mfd/syscon.c                             | 13 +++++++++++++
> >  2 files changed, 16 insertions(+)
> 
> Works for me.
> 
> For my own reference:
>   Acked-by: Lee Jones <lee.jones@linaro.org>

This pachset requires a new version to fix something in the watchdog,
I will add your Ack in the v5.

> 
> How would you like this set to be handled?
> 

Not sure what you mean. Actually, I don't know how it works for such
patchset with changes across multiple subsystems. What are the options?


Damien
