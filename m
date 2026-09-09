Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91853B71A1;
	Wed,  9 Sep 2026 19:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788983703; cv=none; b=ajnKWQLJS/onwUbY1mBL3XyXnh4OHfXU9v+BAOiOBBB1xRBcFxTgCxrR/1H3jhrYYALpc0rs2A3b8iQjohTRwG7PSWV6vfWOuDl72Vn5BPccphF3EPPqrlKCm5LfgwrdyC2Ry5AflEkJBjSBVUmvCg35W/YVHfripO3+t2pd1H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788983703; c=relaxed/simple;
	bh=ZK33/yHp48iM7lECpAU+csFsVZ+moToWUoalJM0ECnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WNsk9hN5b0vYPdMX8FMXHBbNvMBR28SD55X3LDeJHRrZ80Z5kszNv2ZXtVFFHZjUHA2PetEppYLgu8EjprugYq64BIO0z3czZ9I2nNN+K/b/KMVZUqT2r2w4YH/WnkpPTYyTQo7lA6SH+0MGrYApAYW4c/qq9GpJVqdDtvhSxns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=CklZEBUY; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="CklZEBUY"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hgBNV6x4zzKv7l;
	Wed, 09 Sep 2026 21:54:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788983690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Cz5n9xm56pH+3MTfUinQ0zgEJd5ZV0cUn1UlSRbrZ5s=;
	b=CklZEBUYHSHT7TF58KUoIt4EoZr7H7gpDXk/OqOZ8q2WIXpo8r+iI73AS4zALcf6g8mxD8
	j0hG4l3m02nZAVgTsymeaSdPcKVXbazHP+Nc6SPxTNu1/RbYXDyjdtTkJdBNHV3/FjJpkz
	aRZzAN+ce1nGONM7E92fTKmRv5NICAxkOtp4VwDjXhy+sKz/RAW70phX4SLyC0igedzaDk
	zUxECqt+oVZG3MeCqHtNItEhQWI2sbQBzpGqzRDq1i1zptaMEJDgCgoCInhbs6DnX6Rwz1
	OoNYyplRlsaqds5TsTKXtmtd+MDupHbLO1MFAgJPs2uhsJXosYVql5s15PZxdQ==
Date: Wed, 9 Sep 2026 21:54:48 +0200
From: Zakariya Hadrami <zkh@mailbox.org>
To: sashiko-reviews@lists.linux.dev
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, 
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v3 4/4] ARM: dts: mediatek: Add basic support for Amazon
 ford board
Message-ID: <aqGlQGRGgh-7Neo3Wl8J3d-zkh@mailbox.org>
References: <20260908-mt8127-amazon-ford-basic-v3-0-fc46bf1b6cb2@mailbox.org>
 <20260908-mt8127-amazon-ford-basic-v3-4-fc46bf1b6cb2@mailbox.org>
 <20260908220731.0CF1E1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908220731.0CF1E1F00A3A@smtp.kernel.org>
X-MBO-RS-ID: 094c5c28f34bfe6cbde
X-MBO-RS-META: jkdhggqdx6tuda9dcd1rf9hururgwzk1

On Tue, Sep 08, 2026 at 10:07:30PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Device Tree Compiler (DTC) warnings due to using a unit address without a 'reg' property in the simple-framebuffer node.
> --
> 
> commit 03486b0d7f26e5bd328d2d2b8f2a803bdf72c6b4
> Author: Zakariya Hadrami <zkh@mailbox.org>
> 
> ARM: dts: mediatek: Add basic support for Amazon ford board
> 
> This tablet uses a MediaTek MT8127 system-on-chip with 1GB of RAM.
> It can currently boot into initramfs with a working UART and
> Simple Framebuffer using already initialized panel by the bootloader.
> 
> > diff --git a/arch/arm/boot/dts/mediatek/mt8127-amazon-ford.dts b/arch/arm/boot/dts/mediatek/mt8127-amazon-ford.dts
> > new file mode 100644
> > index 0000000000000..21bdab0e43f88
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/mediatek/mt8127-amazon-ford.dts
> 
> [ ... ]
> 
> > +	chosen {
> > +		stdout-path = "serial0:921600n8";
> > +
> > +		framebuffer0: framebuffer@b7a00000 {
> 
> [Severity: Low]
> Will this node name cause Device Tree Compiler warnings during make dtbs?
> 
> Since the node is named with a unit address (@b7a00000) but only uses a
> memory-region property without a corresponding reg property, it seems this
> would trigger a unit_address_vs_reg warning.
> 
> Additionally, it might trigger an avoid_default_addr_size warning because
> its parent (chosen) lacks #address-cells and #size-cells.
> 
> Would it be better to omit the unit address here?
> 

unit_address_vs_reg warning is in fact reported by dtc and DTSpec
explicitly says to use unique node-name without unit-address where no
reg specified. Meanwhile,
Documentation/devicetree/bindings/display/simple-framebuffer.yaml
requires nodes to be named framebuffer@<address>. So I'm a bit confused
and therefore I will keep this unchanged until further reviews on v4.

Missing #address-cells and #size-cells were added in v4.

Thank you!

Link to v4: https://patch.msgid.link/20260909-mt8127-amazon-ford-basic-v4-0-e9af5c420ab1@mailbox.org

> > +			compatible = "simple-framebuffer";
> > +			memory-region = <&framebuffer_reserved>;
