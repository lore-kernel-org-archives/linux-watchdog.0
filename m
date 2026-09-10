Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710C63C9EE8;
	Thu, 10 Sep 2026 09:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789032601; cv=none; b=rcfGWydZRauHmBmBtmOfz7NKRfR+8VtDRLdzPETy550G2gd7uqmfkNyFUJbrv1/Ni8b5jeUrIJG1TbpzOXCRUWCO9LqD+xRwhlGGGZbn7zpEnGfOU6EOlOg5dyFMNtCsOQv3IvdZXEuUetJ/s/82bBBrCWjPMxf2Q36G1NQjNKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789032601; c=relaxed/simple;
	bh=PxNDq22XRY/9sOBL+lIvZftpirBYfi49pQHJ6/5vZkM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AdgQejLFm/jCa79CXZ3JHs1MX9CfQodt2lvVTgHlsHVDhmj9w3nGL7dbYxgGXU4js82ipYYI1xkRmnD0CCizDcMR3ibDnZeGuai5IEw5odRJE0L9s/bmvhpEsdG7GKoUb2HfuzQ3x+yeWtOzF1VQb+IuFu89NeEWDNK7MyxyRA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=he5UQnzy; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="he5UQnzy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1789032596;
	bh=PxNDq22XRY/9sOBL+lIvZftpirBYfi49pQHJ6/5vZkM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=he5UQnzyzLfjpkkTzW8DYrBg9CN7DQBn792CoyEbx4M4X5P23fXdNsjhsYSW3v4ms
	 QAxfOWoopMwPw4GavGwmDRBsc4FDzRmWbKGEKMHEuX12vYXcCXz5eSsVvl+GN2HOV7
	 c1WD7C3h1tXuZf21Z0orFBDXpvH3k3WvTz6YbKXpTmDm+9ulrE4OCMYh6fjqUG3e7v
	 FqLKcsel0gw/rwCsJrqlE9jqU3Vy4fyuTyKaYkynoiQfxUemp+nbdkGXAtMqVoadEq
	 Ls5Q+4DmfTsouRi+u/XaAZP2yxxUKfIqWhZmrP4vXNlJm3PzlzDhHnjranXdxNATA+
	 B5z946qCc5t3w==
Received: from [100.64.1.21] (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id BD11517E0945;
	Thu, 10 Sep 2026 11:29:55 +0200 (CEST)
Message-ID: <ab00e8c8-cbc2-4fe1-8900-f169aeab5a98@collabora.com>
Date: Thu, 10 Sep 2026 11:29:55 +0200
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] ARM: dts: mediatek: Add basic support for Amazon
 ford board
To: zkh@mailbox.org, Matthias Brugger <matthias.bgg@gmail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sean Wang <sean.wang@mediatek.com>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
 linux-watchdog@vger.kernel.org, zkh1@proton.me
References: <20260909-mt8127-amazon-ford-basic-v4-0-e9af5c420ab1@mailbox.org>
 <20260909-mt8127-amazon-ford-basic-v4-4-e9af5c420ab1@mailbox.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260909-mt8127-amazon-ford-basic-v4-4-e9af5c420ab1@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/9/26 21:38, Zakariya Hadrami via B4 Relay wrote:
> From: Zakariya Hadrami <zkh@mailbox.org>
> 
> This tablet uses a MediaTek MT8127 system-on-chip with 1GB of RAM.
> It can currently boot into initramfs with a working UART and
> Simple Framebuffer using already initialized panel by the bootloader.
> 
> Signed-off-by: Zakariya Hadrami <zkh@mailbox.org>
> ---
>   arch/arm/boot/dts/mediatek/Makefile               |  1 +
>   arch/arm/boot/dts/mediatek/mt8127-amazon-ford.dts | 54 +++++++++++++++++++++++
>   2 files changed, 55 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/mediatek/Makefile b/arch/arm/boot/dts/mediatek/Makefile
> index 37c4cded0eae..a610bc75c7d9 100644
> --- a/arch/arm/boot/dts/mediatek/Makefile
> +++ b/arch/arm/boot/dts/mediatek/Makefile
> @@ -14,5 +14,6 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += \
>   	mt7623n-rfb-emmc.dtb \
>   	mt7623n-bananapi-bpi-r2.dtb \
>   	mt7629-rfb.dtb \
> +	mt8127-amazon-ford.dtb \
>   	mt8127-moose.dtb \
>   	mt8135-evbp1.dtb
> diff --git a/arch/arm/boot/dts/mediatek/mt8127-amazon-ford.dts b/arch/arm/boot/dts/mediatek/mt8127-amazon-ford.dts
> new file mode 100644
> index 000000000000..8edad5482de2
> --- /dev/null
> +++ b/arch/arm/boot/dts/mediatek/mt8127-amazon-ford.dts
> @@ -0,0 +1,54 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/dts-v1/;
> +#include "mt8127.dtsi"
> +
> +/ {
> +	model = "MediaTek MT8127 Amazon Ford";

Please be friendlier with whoever reads this model string :-)

	model = "Amazon Fire 7 2015 (Ford)";

that's better, isn't it?

After applying the proposed change,
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Cheers,
Angelo

> +	compatible = "amazon,ford", "mediatek,mt8127";
> +	chassis-type = "tablet";
> +
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +		stdout-path = "serial0:921600n8";
> +
> +		framebuffer0: framebuffer@b7a00000 {
> +			compatible = "simple-framebuffer";
> +			memory-region = <&framebuffer_reserved>;
> +			width = <1024>;
> +			height = <600>;
> +			stride = <(1024 * 2)>;
> +			format = "r5g6b5";
> +		};
> +	};
> +
> +	memory@80000000 {
> +		device_type = "memory";
> +		reg = <0 0x80000000 0 0x40000000>;
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		framebuffer_reserved: framebuffer@b7a00000 {
> +			reg = <0 0xb7a00000 0 0x1000000>;
> +			no-map;
> +		};
> +	};
> +};
> +
> +&uart0 {
> +	status = "okay";
> +};
> +
> +&watchdog {
> +	status = "okay";
> +};
> 
