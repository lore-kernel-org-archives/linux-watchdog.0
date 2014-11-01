Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:17393 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751036AbaKAXGT (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 1 Nov 2014 19:06:19 -0400
Date: Sat, 1 Nov 2014 19:06:01 -0400
From: Jason Cooper <jason@lakedaemon.net>
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Nadav Haklai <nadavh@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v2 2/4] watchdog: orion: Use the reference clock on
 Armada 375 SoC
Message-ID: <20141101230601.GH3698@titan.lakedaemon.net>
References: <1414248522-16055-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1414248522-16055-3-git-send-email-ezequiel.garcia@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1414248522-16055-3-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Wim,

On Sat, Oct 25, 2014 at 11:48:40AM -0300, Ezequiel Garcia wrote:
> The 25 MHz reference clock has better stability so its use is preferred over the
> core clock. Change the Armada 375 clock initialization to use this reference
> clock. To ensure the driver is compatible with an old devicetree, also provide
> a fallback path which will silently return to the previous behavior.
> 
> While here, add the clock specification to the binding documentation.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  .../devicetree/bindings/watchdog/marvel.txt        | 13 +++++++
>  drivers/watchdog/orion_wdt.c                       | 40 +++++++++++++++++++++-
>  2 files changed, 52 insertions(+), 1 deletion(-)

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
