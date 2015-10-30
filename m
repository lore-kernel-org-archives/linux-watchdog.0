Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.savoirfairelinux.com ([208.88.110.44]:48815 "EHLO
	mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759546AbbJ3UHU (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 30 Oct 2015 16:07:20 -0400
Date: Fri, 30 Oct 2015 15:58:04 -0400
From: Damien Riegel <damien.riegel@savoirfairelinux.com>
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, shawnguo@kernel.org,
	kernel@pengutronix.de, wim@iguana.be, robh+dt@kernel.org,
	sameo@linux.intel.com, dinh.linux@gmail.com, linux@roeck-us.net,
	kernel@savoirfairelinux.com
Subject: Re: [PATCH v2 1/5] of: add vendor prefix for Technologic Systems
Message-ID: <20151030195803.GA8666@localhost>
References: <1446150450-22093-1-git-send-email-damien.riegel@savoirfairelinux.com>
 <1446150450-22093-2-git-send-email-damien.riegel@savoirfairelinux.com>
 <20151030180400.GG4058@x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20151030180400.GG4058@x1>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Oct 30, 2015 at 06:04:00PM +0000, Lee Jones wrote:
> On Thu, 29 Oct 2015, Damien Riegel wrote:
> 
> > Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
> > ---
> >  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
> >  1 file changed, 1 insertion(+)
> 
> Acked-by: Lee Jones <lee.jones@linaro.org>

Arnd Bergmann suggested in the v1 thread [1] to change it to
'technologic' to avoid confusion. No problem with that ?

[1] http://www.spinics.net/lists/devicetree/msg100696.html
