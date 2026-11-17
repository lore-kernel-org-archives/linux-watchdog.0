Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.231.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794902318;
	b=aT04skB8+LviGNVixn0WhZvQkKzhEXEZLP+hliNVGeWZrmqCzrWrMRjVUfMnWs05y4zJ
	 OfKLj9o82ON2NXbWOel+uIQSqtGym9IQgyqtMLbiURQHx6OOb0BSJJV+yXuPl2ylKa9lC
	 UxkFPS+OyH/TE7rFm8O/q6A3QAM8gdv+UL6wqq4TdiUCwim15BwkZVrjC9C8jq9Wa7vX4
	 qdfONN+1YEFi+565unV2t3VjyFHwjMcAyYcbYkRAMKYoS1PG32hSuaxCIdBlJiQJGckFv
	 CcYJlR8QUcqwh9S74PmccDFQDRcGABpXPwhWthLrN9qcC7XDjVl/FOZQUu/Cpr+U2LA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794902318;
	h=DMARC-Filter:DKIM-Signature:Date:X-Lms-Return-Path:Content-Type:From:
	 Message-Id:Received:References:User-Agent:Subject:Mime-Version:
	 X-Original-From:In-Reply-To:Content-Transfer-Encoding:To:Cc;
	bh=I7ec6eY4A4tNdQoPCaM8/MCWa6EmraFZtN/PsBNrDHE=;
	b=xIEEdlUyIXcB6XOt5A79lixqOquwbQ6he/dt9sKlWrnbOQ9UbhaoW7OFIkjWu+tV3s2u
	 U/Eo6wVjRPT630sJk/ReKgFnqaOEoMCdnp9dv6KF15BmrSOoapGW79h/0tMXXw1TToN3O
	 C+KgTkg3UA2YJFNMZjreRfUp3RSn4cAvlOJkNO4RTEzCRyuEXMWOTVPaQTMKhZYW6NbN4
	 EltxYXbU5uXYnzdepjVinxhDlQLhTrTr5jUkPKBPDYh6DJLym7gFb9ABalbaZpFnQyanz
	 9j8fVv/QMJox+S6S3IzwrSIKGVo5y136uwicCLNp1w+jlB3aYESqRmBEzTPKk4xPvOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cipunited.com;
	spf=pass smtp.mailfrom=oss.cipunited.com;
	dkim=pass header.d=oss.cipunited.com header.i=@oss.cipunited.com header.a=rsa-sha256 header.s=feishu2303200042 header.b=U1G7Vw0A;
	arc=none smtp.remote-ip=209.127.231.46
Received: from va-2-46.ptr.blmpb.com (va-2-46.ptr.blmpb.com [209.127.231.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C78606A31C
	for <linux-watchdog@vger.kernel.org>; Tue, 17 Nov 2026 07:58:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03C78606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cipunited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cipunited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cipunited.com header.i=@oss.cipunited.com header.a=rsa-sha256 header.s=feishu2303200042 header.b=U1G7Vw0A
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2303200042; d=oss.cipunited.com; t=1794902311;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=I7ec6eY4A4tNdQoPCaM8/MCWa6EmraFZtN/PsBNrDHE=;
 b=U1G7Vw0AFvtgCW407o7BbffGVvkibDb7886ZDQqr3QzSsQjbc5+ylMXyoyWk58828nEePr
 2T8iSP6adsiPhQq9R3grwNMNBPGNNn/hEpqK7/zvBxpyfcS1oCoj9/fNzDQgIJvNyz4dWk
 aqHJ+KdRKQlshah+VFFxwaUdn5cFsYVVGpqvGJLNAhyRJdyc59PrintiYykWhGyKShA0LA
 HxXg0YJ3skljisarBWViem8mI2tS2aPYZFnlz0eDFeCEk7Uir8yD2gK84CNtc7J+fXAU1z
 p2Ra2a+hhdja7tq7l95fkuHmgONgTU1y9s/d3KfnvB+QGFVy988Db/fCTTAu2A==
Date: Tue, 17 Nov 2026 15:53:25 +0800
X-Lms-Return-Path: <lba+26afc0925+9729c9+vger.kernel.org+rongrong@oss.cipunited.com>
Content-Type: text/plain; charset=UTF-8
From: "Rong Zhang" <rongrong@oss.cipunited.com>
Message-Id: <16dbfec04540d41d6aa9bedc4f31b8668394a455.camel@oss.cipunited.com>
Received: from [192.168.8.156] ([171.15.157.139]) by smtp.feishu.cn with ESMTPS; Tue, 17 Nov 2026 15:58:28 +0800
References: <20261113-mips-ls7a-wdt-v2-0-e8abd6b2f77c@oss.cipunited.com> <20261113-mips-ls7a-wdt-v2-3-e8abd6b2f77c@oss.cipunited.com> <sashiko-outbox-212658@kernel.org>
User-Agent: Evolution 3.62.1-3
Subject: Re: [PATCH v2 3/8] MIPS: Loongson64: dts: ls7a-pch: Add missing #address-cells to interrupt controllers
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Original-From: Rong Zhang <rongrong@oss.cipunited.com>
In-Reply-To: <sashiko-outbox-212658@kernel.org>
Content-Transfer-Encoding: 7bit
To: <sashiko-reviews@lists.linux.dev>
Cc: "Rong Zhang" <i@rong.moe>, <linux-watchdog@vger.kernel.org>, 
	<devicetree@vger.kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>

Hi All,

On Fri, 2026-11-13 at 11:01 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Low] MIPS: dts: loongson: invalid #address-cells on ls7a-lpc node
> --
> 
> commit b3cb4b22fb7d7fa764f95bec26fd2bfb7137915e
> Author: Rong Zhang <rongrong@oss.cipunited.com>
> 
> MIPS: Loongson64: dts: ls7a-pch: Add missing #address-cells to interrupt controllers
> 
> This commit adds #address-cells = <0> properties to the pic and lpc
> interrupt-controller nodes in ls7a-pch.dtsi.
> 
> > diff --git a/arch/mips/boot/dts/loongson/ls7a-pch.dtsi b/arch/mips/boot/dts/loongson/ls7a-pch.dtsi
> > index f304f99946f16..28038b8cdd146 100644
> > --- a/arch/mips/boot/dts/loongson/ls7a-pch.dtsi
> > +++ b/arch/mips/boot/dts/loongson/ls7a-pch.dtsi
> 
> [ ... ]
> 
> > @@ -26,6 +27,7 @@ lpc: interrupt-controller@10002000 {
> >  			interrupt-parent = <&pic>;
> >  			interrupts = <19 IRQ_TYPE_LEVEL_HIGH>;
> >  			#interrupt-cells = <2>;
> > +			#address-cells = <0>;
> >  		};
> >  
> >  		ls7a_uart0: serial@10080000 {
> 
> [Severity: Low]
> Does adding #address-cells to the lpc node break dtbs_check schema
> validation?
> 
> Documentation/devicetree/bindings/interrupt-controller/loongson,pch-lpc.yaml
> sets additionalProperties: false and does not define #address-cells.
> Unlike pic, lpc is not referenced by any interrupt-map property, so dtc's
> check_interrupt_map() does not warn about it.

Oops, I must have overlooked the warning in the warning sea...

Will resubmit soon.

Thanks,
Rong
