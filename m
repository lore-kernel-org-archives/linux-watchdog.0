Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.133]:62837 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754638AbbLDQEv (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 4 Dec 2015 11:04:51 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Damien Riegel <damien.riegel@savoirfairelinux.com>,
	Rob Herring <robh@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	devicetree@vger.kernel.org, Russell King <linux@arm.linux.org.uk>,
	linux-watchdog@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Sascha Hauer <kernel@pengutronix.de>,
	Kumar Gala <galak@codeaurora.org>, kernel@savoirfairelinux.com,
	Lee Jones <lee.jones@linaro.org>,
	Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH v7 2/6] mfd: syscon: add a DT property to set value width
Date: Fri, 04 Dec 2015 17:02:53 +0100
Message-ID: <1488444.chqN1XL3OQ@wuerfel>
In-Reply-To: <20151202232102.GB6055@localhost>
References: <1448899191-13891-1-git-send-email-damien.riegel@savoirfairelinux.com> <20151130190015.GA31006@rob-hp-laptop> <20151202232102.GB6055@localhost>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wednesday 02 December 2015 18:21:02 Damien Riegel wrote:
> Lee, Arnd,
> 
> I had to make changes in this patch to address Rob's comments.
> reg-io-width is now in bytes while bus-width was a value in bits. Could
> you please review this patch ?


Ok, that's fine.

> 
> On Mon, Nov 30, 2015 at 01:00:15PM -0600, Rob Herring wrote:
> > On Mon, Nov 30, 2015 at 10:59:47AM -0500, Damien Riegel wrote:
> > > Currently syscon has a fixed configuration of 32 bits for register and
> > > values widths. In some cases, it would be desirable to be able to
> > > customize the value width.
> > > 
> > > For example, certain boards (like the ones manufactured by Technologic
> > > Systems) have a FPGA that is memory-mapped, but its registers are only
> > > 16-bit wide.
> > > 
> > > This patch adds an optional "reg-io-width" DT binding for syscon that
> > > allows to change the width for the data bus (i.e. val_bits). If this
> > > property is provided, it will also set the register stride to
> > > reg-io-width's value. If not provided, the default configuration is
> > > used.
> > > 
> > > Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
> > 
> > Acked-by: Rob Herring <robh@kernel.org>
> > 
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
