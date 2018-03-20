Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mleia.com ([178.79.152.223]:59354 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751472AbeCTXk5 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 20 Mar 2018 19:40:57 -0400
Subject: Re: [PATCH] watchdog: renesas-wdt: Add support for WDIOF_CARDRESET
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-watchdog@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Veeraiyan Chidambaram <veeraiyan.chidambaram@in.bosch.com>,
        Takeshi Kihara <takeshi.kihara.df@renesas.com>
References: <20180320213626.14208-1-wsa+renesas@sang-engineering.com>
From: Vladimir Zapolskiy <vz@mleia.com>
Message-ID: <9d04358d-928f-b1f5-050a-ffb37ad3034b@mleia.com>
Date: Wed, 21 Mar 2018 01:40:55 +0200
MIME-Version: 1.0
In-Reply-To: <20180320213626.14208-1-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Wolfram,

On 03/20/2018 11:36 PM, Wolfram Sang wrote:
> From: Veeraiyan Chidambaram <veeraiyan.chidambaram@in.bosch.com>
> 
> This patch adds the WDIOF_CARDRESET support for the Renessas platform

typo, s/Renessas/Renesas/

> watchdog, to know if the board reboot is due to a watchdog reset.
> 
> This is done via the WOVF bit (bit 4) of the RWTCSRA register, which
> indicates if RWTCNT overflowed, triggering the reset in last boot.
> 
> Signed-off-by: Veeraiyan Chidambaram <veeraiyan.chidambaram@in.bosch.com>
> [takeshi.kihara.df: changed to read the RWTCSRA register while clock is
>  enabled]
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>

--
With best wishes,
Vladimir
