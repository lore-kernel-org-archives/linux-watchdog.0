Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from spo001.leaseweb.nl ([83.149.101.17]:57835 "EHLO
	spo001.leaseweb.nl" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S965042AbbBBW4k (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 2 Feb 2015 17:56:40 -0500
Date: Mon, 2 Feb 2015 23:56:38 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: imx2: Constify struct regmap_config and watchdog_ops
Message-ID: <20150202225638.GA16262@spo001.leaseweb.nl>
References: <1420448957-10106-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1420448957-10106-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Krzysztof,

> The regmap_config struct may be const because it is not modified by the
> driver and regmap_init() accepts pointer to const. Make struct
> watchdog_ops const as well.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Patch added to linux-watchdog-next.

Kind regards,
Wim.

