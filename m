Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-vc0-f170.google.com ([209.85.220.170]:56260 "EHLO
	mail-vc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752804AbaAUJSp (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 21 Jan 2014 04:18:45 -0500
MIME-Version: 1.0
In-Reply-To: <1390295561-3466-10-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1390295561-3466-1-git-send-email-ezequiel.garcia@free-electrons.com>
	<1390295561-3466-10-git-send-email-ezequiel.garcia@free-electrons.com>
Date: Tue, 21 Jan 2014 07:18:44 -0200
Message-ID: <CAOMZO5BDS8Dh1PR6SJv1CK5Pkq5mub-Hs7c4RhxUn7o5efnbKg@mail.gmail.com>
Subject: Re: [PATCH v2 09/15] watchdog: orion: Add per-compatible clock initialization
From: Fabio Estevam <festevam@gmail.com>
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	linux-watchdog@vger.kernel.org,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Andrew Lunn <andrew@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Jan 21, 2014 at 7:12 AM, Ezequiel Garcia
<ezequiel.garcia@free-electrons.com> wrote:

> +static int orion_wdt_clock_init(struct platform_device *pdev,
> +                               struct orion_watchdog *dev)
> +{
> +       dev->clk = devm_clk_get(&pdev->dev, NULL);
> +       if (IS_ERR(dev->clk))
> +               return -ENODEV;

Shouldn't it be 'return PTR_ERR(dev->clk)' instead?


> +       clk_prepare_enable(dev->clk);

clk_prepare_enable may fail, so better check its return value.

Regards,

Fabio Estevam
