Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from spo001.leaseweb.nl ([83.149.101.17]:42800 "EHLO
	spo001.leaseweb.nl" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932306AbbLWQDd (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 23 Dec 2015 11:03:33 -0500
Date: Wed, 23 Dec 2015 17:03:29 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Damien Riegel <damien.riegel@savoirfairelinux.com>
Cc: linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Guenter Roeck <linux@roeck-us.net>, kernel@savoirfairelinux.com
Subject: Re: [PATCH v8] watchdog: ts4800: add driver for TS-4800 watchdog
Message-ID: <20151223160329.GA434@spo001.leaseweb.nl>
References: <1449592648-22701-1-git-send-email-damien.riegel@savoirfairelinux.com> <20151223154359.GA6265@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20151223154359.GA6265@localhost>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Damien,

> On Tue, Dec 08, 2015 at 11:37:28AM -0500, Damien Riegel wrote:
> > This watchdog is instantiated in a FPGA that is memory mapped. It is
> > made of only one register, called the feed register. Writing to this
> > register will re-arm the watchdog for a given time (and enable it if it
> > was disable). It can be disabled by writing a special value into it.
> > 
> > It is part of a syscon block, and the watchdog register offset in this
> > block varies from board to board. This offset is passed in the syscon
> > property after the phandle to the syscon node.
> > 
> > Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
> > Acked-by: Rob Herring <robh@kernel.org>
> > Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> 
> Hi Guenter,
> 
> 
> You have reviewed this patch but not picked it up in your tree. Shall I
> expect Wim to pick it up directly for the next merge window? The board
> would be quite useless without its watchdog driver.
> 
> 
> Thanks,
> Damien

It's on my todo list for the next merge window.

Kind regards,
Wim.

