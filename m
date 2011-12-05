Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailrelay007.isp.belgacom.be ([195.238.6.173]:4262 "EHLO
	mailrelay007.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932169Ab1LETNv (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 5 Dec 2011 14:13:51 -0500
Date: Mon, 5 Dec 2011 20:13:48 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-watchdog@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] [WATCHDOG] move coh901327 state holders
Message-ID: <20111205191348.GU23376@infomag.iguana.be>
References: <1317631978-22818-1-git-send-email-linus.walleij@stericsson.com> <CACRpkdb9+ZsnXFbjJXg-=amnVwYu_EyKftYxRptjq8SDoqurvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdb9+ZsnXFbjJXg-=amnVwYu_EyKftYxRptjq8SDoqurvA@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Linus,

> > From: Linus Walleij <linus.walleij@linaro.org>
> >
> > The state holders used in the PM path of the drivers report as
> > unused variables when compiling without CONFIG_PM so let's
> > move them inside CONFIG_PM.
> >
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Ping on this, Wim is this patch OK?

Patch is OK and has been added to the linux-next branch of the watchdog tree.

Kind regards,
Wim.

