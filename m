Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795090844;
	b=q83WJFr/VN7tuTIWbZCZ4JXvlpKnfeWcYUHehyItn5Xa7CujgUoI1eWgxjcMA7pS2hWD
	 LwvovF22uEFa104VYsgPZy5+hMS4A774JqnGp+fybkYQHi2EXny70e+srDFh+Bzd74FBf
	 EVaqEUPrC6At9cZqpSmmyNPuw/9SIbB0/aglqYyC8jm1UZyokF54yqwkn7h2pagIq/yqC
	 g9wG6/VgzNZtKAG8g9umCCiqkpJhFGPLR8YHQIPJ028xOicA6iPD/Gw29lXh7ICDEyTCE
	 R8di8Ae0GSsywdLPCzP683Lkjx0wZwEe79Fk223yXc8GG4fuPqDWWdVfoC2vnEulRaQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795090844;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient;
	bh=xIXJW7MCtZTIdpOIfOfmjYbyy/As+k09mrpNNQszvtI=;
	b=GVMuQK0lvm2Guz5VByHynIKV03Rr7CAr/6xRSXBMyaJGqUEv/hj+J2NjPsc/Zargz61S
	 1CKsMLP3Vex8TeHdIJzbNK28J6Ucfxufr4mH+R3+4oVN2rVADo/k6uqMe8QYbO7VZp8Xu
	 Xp0TsJ/4fU19ffhaiIeEMdilH7QayZMh99xpy02nYDEEIPD9leo324qQQlK/e6GZGbr8H
	 tMtAv2vTo2L0Z4u44D7RpJUxp+g9p4hA8Z+nPt4YyB/UENWdU0W6Xg1c/eFThHbUqSwP3
	 S++rc/XLePpRpEnnpyLs1nUBcZRNt8fqPwaH5NE7AYx2KD+1CE3Ctd++pYAoJHlurZw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ziyao.cc;
	spf=pass smtp.mailfrom=ziyao.cc;
	dkim=pass header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=gNNpp7dX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.15
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com [165.173.182.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4186A606A325;
	Thu, 19 Nov 2026 12:20:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4186A606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=gNNpp7dX
ARC-Seal: i=1; a=rsa-sha256; t=1795090809; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=KpbKCN1VuYF2IfZV/2FOHpzs7hLrqnFnRmmyW3ggEzitgaSYpLyVw3pnQWzhinfLzDT27i3mMQK2bnV5J3h3lVe/SaBXXgkOeAPXhnxAgtCLs2IjfbWMpSjHpQ97D/OzmUBY3LXdltPKRO59a1cC4LtIZU4cClAf2Ik3jCFgVbI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795090809; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=xIXJW7MCtZTIdpOIfOfmjYbyy/As+k09mrpNNQszvtI=; 
	b=ITrksx1rQzSswiO6qbs8J1fOdqc7flC8t5H+y4u0gKLM6GSYehKYyPUKVduQqaTLO6zAW46biV2/cACDkFbcesnyX+LbSNyL1maFY+99orMXTurpPxBEo1rzwoYDPv92TttlLW3sr5aiQ7fsdTYzMdSVs7pFuDo4ciSnZxcQoGg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=ziyao.cc;
	spf=pass  smtp.mailfrom=me@ziyao.cc;
	dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: a=rsa-sha256; b=gNNpp7dXVGfo9wL3/0jFEoHQHULJ7GSpQln1xRfVnXHfBSNwjvfMgkvKxvBV6tXluYLKZo6+M0EOddA+QckdgxUQpkwdp+7k9AevWpLB6quSaLd9atPf96X+fPzKOiUMkZF2qaBWgy09BgQM7e90EeWZmewl3Kykohb2Amrw1is=; c=relaxed/relaxed; s=zmail; d=ziyao.cc; v=1; bh=xIXJW7MCtZTIdpOIfOfmjYbyy/As+k09mrpNNQszvtI=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 179509080710384.30861796368492;
	Thu, 19 Nov 2026 04:20:07 -0800 (PST)
Date: Thu, 19 Nov 2026 12:19:57 +0000
From: Yao Zi <me@ziyao.cc>
To: "Rong Zhang" <rongrong@oss.cipunited.com>,
	"Keguang Zhang" <keguang.zhang@gmail.com>,
	"Wim Van Sebroeck" <wim@linux-watchdog.org>,
	"Guenter Roeck" <linux@roeck-us.net>,
	"Rob Herring" <robh@kernel.org>,
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>,
	"Conor Dooley" <conor+dt@kernel.org>,
	"Thomas Bogendoerfer" <tsbogend@alpha.franken.de>
Cc: "Rong Zhang" <i@rong.moe>, "Yao Zi" <me@ziyao.cc>,
	"Icenowy Zheng" <uwu@icenowy.me>,
	"Jiaxun Yang" <jiaxun.yang@flygoat.com>,
	<linux-mips@vger.kernel.org>, <linux-watchdog@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 5/8] MIPS: Loongson64: dts: ls7a-pch: Add
 miscellaneous clock node
Message-ID: <av7pbVpkdO8dFGH7@pie>
References: <20261113-mips-ls7a-wdt-v2-0-e8abd6b2f77c@oss.cipunited.com>
 <20261113-mips-ls7a-wdt-v2-5-e8abd6b2f77c@oss.cipunited.com>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261113-mips-ls7a-wdt-v2-5-e8abd6b2f77c@oss.cipunited.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/295.87.94
X-ZohoMailClient: External

On Fri, Nov 13, 2026 at 06:51:12PM +0800, Rong Zhang wrote:
> The Loongson-7A has an internal clock source for miscellaneous
> peripherals. The clock source is nonconfigurable and has a fixed 50MHz
> clock frequency.
> 
> Add a 50MHz fixed-clock node with label "pch_misc_clk" to represent it.
> 
> Signed-off-by: Rong Zhang <rongrong@oss.cipunited.com>
> ---
>  arch/mips/boot/dts/loongson/ls7a-pch.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/mips/boot/dts/loongson/ls7a-pch.dtsi b/arch/mips/boot/dts/loongson/ls7a-pch.dtsi
> index 9f0a183bd348..2ef1ad10a8ec 100644
> --- a/arch/mips/boot/dts/loongson/ls7a-pch.dtsi
> +++ b/arch/mips/boot/dts/loongson/ls7a-pch.dtsi
> @@ -1,6 +1,12 @@
>  // SPDX-License-Identifier: GPL-2.0
>  
>  / {
> +	pch_misc_clk: clock-50000000 {
> +		#clock-cells = <0>;
> +		compatible = "fixed-clock";
> +		clock-frequency = <50000000>;

"compatible" property usually comes before other properties other than
"device_type", see dts-coding-style.rst.

With this fixed,

Reviewed-by: Yao Zi <me@ziyao.cc>

> +	};
> +
>  	pch: bus@10000000 {
>  		compatible = "simple-bus";
>  		#address-cells = <2>;
> 
> -- 
> 2.55.0

-- 
Thanks,
Yao Zi

Meow-mrrp-mrow, I'm a cat.
