Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D9B3E3C5E;
	Thu,  9 Jul 2026 07:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783582284; cv=none; b=dNJmmrBLm2iESdJn8505Prw6zARz9Xl0vq0DKZ9z9nN4nBlTr3HPUWa1hpFethVwz6NeK0bjYLjOZgkhqczecwct73W2DstQyjWilYQSSNM+nk3Fit9AgjDKwtmpxOOMABVxjinNmplZGvwHJX0tq6KZ5TNkiweB/8/xrIIs8Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783582284; c=relaxed/simple;
	bh=NPB7aHPbMrTwa1cMmx6O1WU8meIDBRJqQURXsAVEYMA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RWcjbAFWHEW9sbRqv2s5+moAAAnM2QOV1Up8HAGzlo+RjDfNV5oaBNApBa8V+s7maNTjMmuH0npJZlAbU0RUUdecLcCaTxrpFOT1d6zUDihORxIxk3yB2v6PrA40RlE/NfAlIQz4VfSTip8N/LPcTX0ZzDfAcR0wQwXkJ/kfcSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=OPTyKTLW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=maozbj8a; arc=none smtp.client-ip=103.168.172.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="OPTyKTLW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="maozbj8a"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailflow.phl.internal (Postfix) with ESMTP id 0D3BE13800A6;
	Thu,  9 Jul 2026 03:31:22 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Thu, 09 Jul 2026 03:31:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1783582282;
	 x=1783589482; bh=gHJ1QfpGBkrW1qP1BHt95BjrEUjf2vjREcz3XZeR9bE=; b=
	OPTyKTLWg7qTVvkBSDCOglN+/5PulKX0eDNBbb79ZQsH02A+sJT0LJZGt1BxuY7Q
	OU9kMCRI5YHM9Egca01aWSBnFKYl443xk/92MdXRoQDg4lVCDRH6pMw+1SckZESF
	2Ytc162g8NUaGnyz9/CsGTQgAvulkBnD5LKAf8wgQHfKVd9lWnISn7jZCwq39/d2
	e0r46sM7CjlGnJC4OQvhLxJXCPSP99jqTbbpHyPCtJT/a92QB52Ec1coHrWgC4lS
	AGvv3tp6nhw3QNJ31ZLFUqONZt2aJXpH6FLT7ZOgWolAZgu1UyBRQiYubSUo+yuZ
	Ec13CffXvW9T4cobM2O4lA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783582282; x=
	1783589482; bh=gHJ1QfpGBkrW1qP1BHt95BjrEUjf2vjREcz3XZeR9bE=; b=m
	aozbj8aKmP0aX48ddcE8zbFsQ8U9WPssj13h+AgMkbWiPnI+8tKQ6OWEukBBpmIR
	SqUy/ScaxBsRhKsnjuxLv0WX/sBsYbbYFeUCMAlCjGlTM9ZmerkNUmpD8VOsbOhy
	oNmB03HotMJCMbeBWuK8Sf5CCheb892K1l4WMeVRR3M6iAHsc6sKa3N5Npb3bKKW
	gwhGgyTkkWLh6WFkGzuuQEmHGbK1OAV8N9qaTw604WPLzRtWfBZYSO7tYkCjY9Aa
	YETDRoAFaWkScTUFSXKtUVmFuDD+hMrnO78OnsaN1ydTynPenMrlffzEA2VoZHdo
	b0+8UDwVTOJZI7FRrgUzQ==
X-ME-Sender: <xms:SU5PaqTlVRq7woG74U2P_1TnusN1kJzKSc8RDOl_3qfgLcLYcK6oBQ>
    <xme:SU5PakoSZVA83k-01WncQxDMANdsoiDDfRf86h7-Y-bWs70nvrspO6_3Shyg7CbkS
    3WvXYmXMvWHrwcYxYm-zpoU_86E7KsvtLwNch6lerysVFBQ2qLdZmSe>
X-ME-Received: <xmr:SU5PalZW22kJXFCe7zLn8RuEoMs5e0Z9BEIEu5zCGgO1X9aGYtHGlm72FGBKT5ScqWbthlBNo80LKaVyAG5Bu6buZyhJ9fT6zJs>
X-ME-Proxy-Cause: dmFkZTGtcogUzsgGVSIfMmART6Z9XmtSrTIIEh/iBSqj8X1qDc34PC3kbgB7tR/vwLzKVf
    kqvFRO9dmgluv19XwE/AsIwQzOX8oXecvdVPJjjrZr3jnaou2iSke/y82ZyCP3L5qDkakt
    dur3RuUXkCTbrAhoF8QEq0O718G/XzfnJoqPLA6j2kxRHBxF4K/CgEK5IxmHjModRqpExw
    e0X9mprIbHqtSIkWvRcBteaL8/34ubH5hdAhAS2Eb0osfVj0njIZqL54O04DtPszZ5sHbx
    odRhuNJJ6vR5N7Wkl0UhPFlvdKhQKNlTg2ojEls9M+9ySrFL9ygZvOC7z41GE7FKjCrSlx
    CJYscv4HKXdWQqJHCLEF7eCiYN9Y6XyzbhDJrNhxjXut7TgbktrqKgfF65yYAfjkXSD4Oa
    XFc6bk4j/0wX4ADySl7q1gh6RfFa8gQjQfQVNcO823maitytcqNFPnhuk6//tmABYCeMKc
    ijouPJt0ER8jf6hr8dVX3vFDiAp+p3ZKTCfzHcN5xouv1ACthkQyN3fxTNABT/NdnSlKE0
    hybd03Ness7ejj/PWjhOUTmOve3tCHDm91dHwuwJG6WPPv5BfXixaQ/sQXzMw9JtPwA3Gt
    E/0xjnxO2u4JQNFLfzfjWnz95/pgvleeKPlv1aiJ1D594X0iRSyn5f3majlw
X-ME-Proxy: <xmx:SU5PaoHW31nChDkdhM1kU8cgT1aGRl2hF5I1QDgxyn_52XjxxSUsAQ>
    <xmx:SU5PaiqUOpj1uxyWrxbY1YV7VxhBlsaOl47l4VtLKhSpfnSbHR3NvQ>
    <xmx:SU5PakkZ8ULFKKtmKAsatldukDzB9MCkNiixxnsH7jxNgPyHQAud_w>
    <xmx:SU5PavuZaAPeSqkMi3KthoPNkqhXSYBqIsP2mhxZ76jSEJn-k3nX3g>
    <xmx:Sk5PatAYsXFdqTgnfeYQWaQ05dLQFSgJ6RZVlQXBnE7UvizxMhqOADgL>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jul 2026 03:31:21 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Thu, 09 Jul 2026 09:30:49 +0200
Subject: [PATCH 03/11] dt-bindings: interrupt-controller: apple,aic2: Add
 apple,t6031-aic3 compatible
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-apple-t603x-initial-devices-v1-3-55b305833123@jannau.net>
References: <20260709-apple-t603x-initial-devices-v1-0-55b305833123@jannau.net>
In-Reply-To: <20260709-apple-t603x-initial-devices-v1-0-55b305833123@jannau.net>
To: Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Linus Walleij <linusw@kernel.org>, 
 Mark Kettenis <kettenis@openbsd.org>, Andi Shyti <andi.shyti@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Sasha Finkelstein <k@chaosmail.tech>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-watchdog@vger.kernel.org, linux-gpio@vger.kernel.org, 
 linux-i2c@vger.kernel.org, linux-pwm@vger.kernel.org, 
 Janne Grunau <j@jannau.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1180; i=j@jannau.net;
 h=from:subject:message-id; bh=NPB7aHPbMrTwa1cMmx6O1WU8meIDBRJqQURXsAVEYMA=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhix/P9sNqw94p5YIZ3YE6jAtZZB5oHBz3wGGPFYv89Ag3
 tTpm5w6JrIwiHExWIopsiRpv+xgWF2jGFP7IAxmDisTyBBpkQYGIGBh4MtNzCs10jHSM9U21DM0
 0jHWMWLg4hSAqY7fzchwvavdn3uOZeuP+R9nvdvWuW/lwtpT907ErjO55c9odvIzD8MfvuNfe24
 vqaiIf7l6vk7uWqE/qaJld53bS5grXL52f+plBwA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419

The Apple M3 Max and Ultra SoCs use AICv3 as interrupt controller. It is
compatible to the base M3 AICv3. Add "apple,t6031-aic3" as compatible
and add it to the list for 4 #interrupt-cells used for multi-die SoCs.

Signed-off-by: Janne Grunau <j@jannau.net>
---
 Documentation/devicetree/bindings/interrupt-controller/apple,aic2.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/apple,aic2.yaml b/Documentation/devicetree/bindings/interrupt-controller/apple,aic2.yaml
index a94787939d34..726a6720e05f 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/apple,aic2.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/apple,aic2.yaml
@@ -44,6 +44,7 @@ properties:
       - items:
           - enum:
               - apple,t6030-aic3
+              - apple,t6031-aic3
           - const: apple,t8122-aic3
       - const: apple,t8122-aic3
 
@@ -130,6 +131,7 @@ allOf:
             enum:
               - apple,t6000-aic
               - apple,t6020-aic
+              - apple,t6031-aic3
     then:
       properties:
         '#interrupt-cells':

-- 
2.54.0

