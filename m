Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:50427 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751662AbeEPG7g (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 16 May 2018 02:59:36 -0400
Date: Wed, 16 May 2018 08:59:32 +0200
From: Simon Horman <horms@verge.net.au>
To: linux-renesas-soc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
        Magnus Damm <magnus.damm@gmail.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] ARM: multi_v7_defconfig: Enable RENESAS_WDT
Message-ID: <20180516065931.amccl5sr7i6dengd@verge.net.au>
References: <20180502094353.27488-1-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180502094353.27488-1-horms+renesas@verge.net.au>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, May 02, 2018 at 11:43:53AM +0200, Simon Horman wrote:
> R-Car Gen2 and RZ/G1 platforms come with a watchdog IP, therefore enable
> its driver by default. It is enabled as a module to avoid increasing
> the kernel image size.
> 
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Applied.
