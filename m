Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7668F2DF131;
	Thu, 12 Feb 2026 09:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770889952; cv=none; b=fXPyZ+cvhXQLcjG3J+gUzMBbBI3UmJ9MmhSq9HlnORK6bK+dwCv5EO7ErsW4joggLB+aUMMAhKXunrA/4IxCe73jwnmgPQVrKGyNnYzvenskA+uz+L1Pz/pXPbtuS7LicVNFu8/V7lY5fVeZc453uaZSSvRX4cFFQ85C3Lc6Si0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770889952; c=relaxed/simple;
	bh=Oyj79ZYPPb9fjfhBXxDNVreliut+vA9nSSdyxHrxr8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OBBEDhFiIno/z5Um4lFPT552EOCb4XWLEE2gmM72jFYfmV3VghP8kcurHWghMUq2MNAKxhrxidhCY2xOnb5Jsr8rX4Vod1ycFs743YfenRp46nEuGW/1J0uBHjyz4NDEq15a+kBGzlja7yHmawbL19IsNArembDSkJsWEdqFrsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=D7gbsXhS; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="D7gbsXhS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1770889949;
	bh=Oyj79ZYPPb9fjfhBXxDNVreliut+vA9nSSdyxHrxr8M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=D7gbsXhSQ/BexUUN5j8FGV8j06Q6qAxSOuDzcAGyzp/SrQLiXGBEe/6gd7SI0KWvt
	 kwM9lv0EZutE88KJJRXcBndzXwrv4tsNnup4OlZqLk2L/r0KAY4zFwBHVPntIXUQ2m
	 iMxDX7lpf7OE8NSsUUFKQ1ntnMB7snxdgChrHggoXl4ozt3Gy2uKy8CKfiodsX0cmc
	 uNlKMzIqPx+rRhBxVJMg3vuIkE94woPxjsHmvXjPfEX0lRFhrM37gJvL6Bm6D6QJcF
	 UwqGjtglR8OPZBoR7xCucwBbIqz2cC6VRIUDM6FVaSNg3Ae8nbzy/VSjS7/hPXcm3m
	 Rpt1QIp/sfQEw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3BF3017E12D5;
	Thu, 12 Feb 2026 10:52:29 +0100 (CET)
Message-ID: <7ec57033-b0d8-4aa5-b23c-a7ab62fd38f4@collabora.com>
Date: Thu, 12 Feb 2026 10:52:28 +0100
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] soc: mediatek: mtk-mmsys: Add resets for mt8167
To: Luca Leonardo Scorcia <l.scorcia@gmail.com>,
 linux-mediatek@lists.infradead.org
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, linux-watchdog@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <cover.1770836189.git.l.scorcia@gmail.com>
 <0ab331c556d76ddfc7f287d6288c4f60f4ef90c8.1770836190.git.l.scorcia@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <0ab331c556d76ddfc7f287d6288c4f60f4ef90c8.1770836190.git.l.scorcia@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 11/02/26 20:03, Luca Leonardo Scorcia ha scritto:
> The mt8167 SoC has 64 MMSYS resets, split in two contiguous 32-bits
> registers, MMSYS_SW0_RST_B (0x140) and MMSYS_SW1_RST_B (0x144), as
> also stated in the downstream kernel for the Lenovo Smart Clock
> in the ddp_reg.h header.
> 
> Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
> ---
>   drivers/soc/mediatek/mt8167-mmsys.h | 3 +++
>   drivers/soc/mediatek/mtk-mmsys.c    | 2 ++
>   2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/soc/mediatek/mt8167-mmsys.h b/drivers/soc/mediatek/mt8167-mmsys.h
> index eef14083c47b..2d20b21fb0ea 100644
> --- a/drivers/soc/mediatek/mt8167-mmsys.h
> +++ b/drivers/soc/mediatek/mt8167-mmsys.h
> @@ -18,6 +18,9 @@
>   #define MT8167_DSI0_SEL_IN_RDMA0			0x1
>   #define MT8167_DSI0_SEL_IN_MASK				0x3
>   
> +#define MT8167_MMSYS_SW0_RST_B				0x140
> +#define MT8167_MMSYS_SW1_RST_B				0x144
> +
>   static const struct mtk_mmsys_routes mt8167_mmsys_routing_table[] = {
>   	MMSYS_ROUTE(OVL0, COLOR0,
>   		    MT8167_DISP_REG_CONFIG_DISP_OVL0_MOUT_EN, OVL0_MOUT_EN_COLOR0,
> diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
> index bb4639ca0b8c..03cbc393f978 100644
> --- a/drivers/soc/mediatek/mtk-mmsys.c
> +++ b/drivers/soc/mediatek/mtk-mmsys.c
> @@ -57,6 +57,8 @@ static const struct mtk_mmsys_driver_data mt8167_mmsys_driver_data = {
>   	.clk_driver = "clk-mt8167-mm",
>   	.routes = mt8167_mmsys_routing_table,
>   	.num_routes = ARRAY_SIZE(mt8167_mmsys_routing_table),
> +	.sw0_rst_offset = MT8167_MMSYS_SW0_RST_B,
> +	.num_resets = 64,

Unless you have the full reset table...

	.rst_tb = (const u8[]) {
		[MT8167_MMSYS_SW0_RST_B_SMI_COMMON] = MMSYS_RST_NR(0, 0),
		[MT8167_MMSYS_SW0_RST_B_SMI_LARB] = MMSYS_RST_NR(0, 1),
		[MT8167_MMSYS_SW0_RST_B_CAM_MDP] = MMSYS_RST_NR(0, 2),
		[MT8167_MMSYS_SW0_RST_B_MDP_RDMA0] = MMSYS_RST_NR(0, 3),
		[MT8167_MMSYS_SW0_RST_B_MDP_RSZ0] = MMSYS_RST_NR(0, 4),
		[MT8167_MMSYS_SW0_RST_B_MDP_RSZ1] = MMSYS_RST_NR(0, 5),
		[MT8167_MMSYS_SW0_RST_B_MDP_TDSHP0] = MMSYS_RST_NR(0, 6),
		[MT8167_MMSYS_SW0_RST_B_MDP_WDMA] = MMSYS_RST_NR(0, 7),
		[MT8167_MMSYS_SW0_RST_B_MDP_WROT0] = MMSYS_RST_NR(0, 8),
		[MT8167_MMSYS_SW0_RST_B_DISP_DSI0] = MMSYS_RST_NR(0, 22),
	},
	.num_resets = 10,


Cheers,
Angelo

>   };
>   
>   static const struct mtk_mmsys_driver_data mt8173_mmsys_driver_data = {


