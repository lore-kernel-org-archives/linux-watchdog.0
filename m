Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:37628 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932643Ab1CWULQ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 23 Mar 2011 16:11:16 -0400
MIME-Version: 1.0
In-Reply-To: <c4422b4a8ee132d3adac95fd86237c61b2f8b364.1300909446.git.joe@perches.com>
References: <cover.1300909445.git.joe@perches.com>
	<c4422b4a8ee132d3adac95fd86237c61b2f8b364.1300909446.git.joe@perches.com>
Date: Wed, 23 Mar 2011 21:11:15 +0100
Message-ID: <AANLkTikOJ4ed+ExLs1Okm2iFrE95SmR1809bT43bzm8X@mail.gmail.com>
Subject: Re: [trivial PATCH 1/2] treewide: Fix iomap resource size miscalculations
From: Linus Walleij <linus.walleij@linaro.org>
To: Joe Perches <joe@perches.com>
Cc: Jiri Kosina <trivial@kernel.org>,
	Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>,
	David Brown <davidb@codeaurora.org>,
	Daniel Walker <dwalker@fifo99.com>,
	Bryan Huntsman <bryanh@codeaurora.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Russell King <linux@arm.linux.org.uk>,
	Ralf Baechle <ralf@linux-mips.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mips@linux-mips.org, linux-arm-msm@vger.kernel.org,
	linux-fbdev@vger.kernel.org, linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

2011/3/23 Joe Perches <joe@perches.com>:

> Convert off-by-1 r->end - r->start to resource_size(r)
>
> Signed-off-by: Joe Perches <joe@perches.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>
(for ux500)

Yours,
Linus Walleij
