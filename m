Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE77748F017;
	Tue,  8 Sep 2026 22:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788905252; cv=none; b=RNjm1c5XjiqankpZH9EamQI5l1ZR7nMy8bNRr8/5wF+sa/iH8VdY7GRjSBh510tiAXXsslLHQ1XFCoKNTJC++1BB9E2v2RU/cSXtjOiPVgcXOT1vqpOnQmgJHJlVGWrKLuPhmS83MQsfEBXl9OFx8a2+9jvCVHbaqKDEsNoY7GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788905252; c=relaxed/simple;
	bh=uH5244xLkHh5tX3Dib7zbddMlpVeIRO6MVtfqaE05tg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cYPme55tz6dUN7cF9k696FqmlEjdjLZIeTzqW4L1lgbNfpF3YvHZbf7+WjHSPSXTcFf48YHgQrFOnrSSzwjeYMqzsw4NJzEz0JL0BMdm/4P3ZrTD8Or23OWIA1CrOj2gWvsv8H8S+uwFm3UzAZHVjOXg14qXWgMaohxGefN5mMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CfBSgd3p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CfBSgd3p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CF1E1F00A3A;
	Tue,  8 Sep 2026 22:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788905251;
	bh=ws1+Xls/DEAU0aHZG1BtMNrUT8GjPjqImlOpVAgnj/U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CfBSgd3pRdedFd1iSIASn8xbXTRS7pra0Rw5ga8G/yuT3u78tWb3OdWBUindLxyMt
	 u/MTe/1hBx7CSZSNU7BuAtRQyXsmkvrK2gDiZm8gdlQiqHgNzNpHbFpoJYqlXK5j8d
	 U5VrZj0bIcqfDGnEFkhcUo61HlkAAeiqa75px2c1KytR72i66KIxdEtOQ8O5wHi2+7
	 7mkEI/VPDynr/a2YxBA2v+PIY8jegoQchfSpd1J48T4mgUU5Y+kjj7z/A6KLQ9g6k/
	 qOn8lGslPEl2WpJxA/5KE0gLHndVFjVZRUPpoh/qJODmXF1GOATf5y5NhFG57QXO5G
	 aNr36NcnyZf/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/4] ARM: dts: mediatek: Add basic support for Amazon
 ford board
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zakariya Hadrami" <zkh@mailbox.org>
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org
In-Reply-To: <20260908-mt8127-amazon-ford-basic-v3-4-fc46bf1b6cb2@mailbox.org>
References: <20260908-mt8127-amazon-ford-basic-v3-0-fc46bf1b6cb2@mailbox.org>
 <20260908-mt8127-amazon-ford-basic-v3-4-fc46bf1b6cb2@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 22:07:30 +0000
Message-Id: <20260908220731.0CF1E1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Device Tree Compiler (DTC) warnings due to using a unit address wit=
hout a 'reg' property in the simple-framebuffer node.
--

commit 03486b0d7f26e5bd328d2d2b8f2a803bdf72c6b4
Author: Zakariya Hadrami <zkh@mailbox.org>

ARM: dts: mediatek: Add basic support for Amazon ford board

This tablet uses a MediaTek MT8127 system-on-chip with 1GB of RAM.
It can currently boot into initramfs with a working UART and
Simple Framebuffer using already initialized panel by the bootloader.

> diff --git a/arch/arm/boot/dts/mediatek/mt8127-amazon-ford.dts b/arch/arm=
/boot/dts/mediatek/mt8127-amazon-ford.dts
> new file mode 100644
> index 0000000000000..21bdab0e43f88
> --- /dev/null
> +++ b/arch/arm/boot/dts/mediatek/mt8127-amazon-ford.dts

[ ... ]

> +	chosen {
> +		stdout-path =3D "serial0:921600n8";
> +
> +		framebuffer0: framebuffer@b7a00000 {

[Severity: Low]
Will this node name cause Device Tree Compiler warnings during make dtbs?

Since the node is named with a unit address (@b7a00000) but only uses a
memory-region property without a corresponding reg property, it seems this
would trigger a unit_address_vs_reg warning.

Additionally, it might trigger an avoid_default_addr_size warning because
its parent (chosen) lacks #address-cells and #size-cells.

Would it be better to omit the unit address here?

> +			compatible =3D "simple-framebuffer";
> +			memory-region =3D <&framebuffer_reserved>;
> +			width =3D <1024>;
> +			height =3D <600>;
> +			stride =3D <(1024 * 2)>;
> +			format =3D "r5g6b5";
> +		};
> +	};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-mt8127-ama=
zon-ford-basic-v3-0-fc46bf1b6cb2@mailbox.org?part=3D4
