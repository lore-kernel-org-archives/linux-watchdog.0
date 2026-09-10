Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21D83E0C47;
	Thu, 10 Sep 2026 09:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789032604; cv=none; b=hkGDFJQIdng2biMP8cNN6lCa0dlXnAnww9KW1nGHugYqghO2YR1JjHW2/fcw+WS5h8wXi+GFSkGxbFkt7QkJWwVbgEBNBTmfzlKkImho2RgeW6VIv5xFlOv+1zZSqF0VwDuQbzMu3ZjeZt9LVxzkQBzwi5p7vHSx0eDSErKlIOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789032604; c=relaxed/simple;
	bh=IYAf/0uTqDEHjYUNJHPrzwYkqDC7PC1hMbv3pif6maY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dzBQPxTeRhDa4c2nCMGWzxLhp9MLvhPVzhJlNEM+y+3kQ8CYFtnkkjtjsFlf+BdZFhJFg41zAL8782cgOVtQipeoR5cZwqZWT0tQOM5I8o/kWOFcfFySlOgIxOCPGPhLpd1ZhiJvlGXBKPVFb6/SuAZ+NDcbBJqswWhfscH1JH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=V3qdTsOz; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="V3qdTsOz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1789032599;
	bh=IYAf/0uTqDEHjYUNJHPrzwYkqDC7PC1hMbv3pif6maY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=V3qdTsOz1DbFEG4Q56tPCGZK2r12HcgpwcsQqMmzqiqiFMg3ZwlQJfxpvLyVo1CWA
	 OU1uJ6t5sAYdcYTQDFdWF2L5hctJ3IOwqVz4U6Uzw/ISmvO5/DfETz8I53ka5WQTpa
	 rccPnXVy8L6esVPEmpwQCBtxoEIEq+9FVKjjUzmGiRQg4EprW5gtVgrLfcVbetUUHl
	 VxroTCPPXzP/0g2/f51kXqDTi4ijRNdS8SPFFzKdOhPw15jzNOluR8/iHuzhgQ8cl0
	 Y6ag4DvBb7V76zs+hNJ1fG3j7HshCJfLgTFzEPYJGV1sE6kzaOmSfQBjMsBVxEgNxe
	 r3LfszAsOwODw==
Received: from [100.64.1.21] (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DB25517E0C7E;
	Thu, 10 Sep 2026 11:29:58 +0200 (CEST)
Message-ID: <71d15182-c90c-4c50-902c-1d14af9ed54e@collabora.com>
Date: Thu, 10 Sep 2026 11:29:58 +0200
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] ARM: dts: mediatek: mt8127: Add watchdog support
To: zkh@mailbox.org, Matthias Brugger <matthias.bgg@gmail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sean Wang <sean.wang@mediatek.com>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
 linux-watchdog@vger.kernel.org, zkh1@proton.me
References: <20260909-mt8127-amazon-ford-basic-v4-0-e9af5c420ab1@mailbox.org>
 <20260909-mt8127-amazon-ford-basic-v4-3-e9af5c420ab1@mailbox.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260909-mt8127-amazon-ford-basic-v4-3-e9af5c420ab1@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/9/26 21:38, Zakariya Hadrami via B4 Relay wrote:
> From: Zakariya Hadrami <zkh@mailbox.org>
> 
> Add watchdog node and disable it by default as it was not present
> initially.
> 
> Signed-off-by: Zakariya Hadrami <zkh@mailbox.org>
> ---
>   arch/arm/boot/dts/mediatek/mt8127.dtsi | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/mediatek/mt8127.dtsi b/arch/arm/boot/dts/mediatek/mt8127.dtsi
> index bd61ec7e70c0..3e23673e7a9e 100644
> --- a/arch/arm/boot/dts/mediatek/mt8127.dtsi
> +++ b/arch/arm/boot/dts/mediatek/mt8127.dtsi
> @@ -99,6 +99,13 @@ soc {
>   		compatible = "simple-bus";
>   		ranges;
>   
> +		watchdog: watchdog@10007000 {
> +			compatible = "mediatek,mt8127-wdt","mediatek,mt6589-wdt";

Missing space:

compatible = "mediatek,mt8127-wdt", "mediatek,mt6589-wdt";

After fixing,

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

P.S.: If you send a v5 between now and now (or next week too :-P) I can pick it
in this cycle.

Cheers,
Angelo

> +			reg = <0 0x10007000 0 0x100>;
> +			interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_LOW>;
> +			status = "disabled";
> +		};
> +
>   		timer: timer@10008000 {
>   			compatible = "mediatek,mt8127-timer",
>   					"mediatek,mt6577-timer";
> 
