Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794994097;
	b=24gGgfp7LicWggAF9XRuCwVjdyFplC5eahGJFwsOEdDxYke69Z26W2gcHJFFCKhDUOL6
	 cPjj7PmfcN9h9swiHcMXF2QrDbHIM9ZSBcQT4cCsUJG0WJZ1FLcFIB42RhkiazUn2I81v
	 gVwKW/xLZI+gGLHw6LET3XO92imMA4LiLClpfCS/DC3UpT4HZkVR3ZO3t7k211wd70khG
	 +ujIm1mZZMU0hZTWRmugjkWCphSvUNbkJZsd5tMkmxQWtYukqnYEyAxQTW1mCz2yGOZqn
	 fquUaTIg7fJLntFQpcuOkPjddC1TntapomJ7I+khESa/7kaQa96IX32O9/U6aVMHqAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794994097;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3ZsQ1RQW9HsIzrN77N2oVBaxnZKiAj1l1ATVrYAyRQA=;
	b=si6cuA/qVRtxth8JyCH/7SNfdjPdyCtsbvrnZM1llQhrd+5XJS885DY2CtrVwDcM41GQ
	 R/zFfL6FIk1Xf9Og6Bdnn2MhNS83vxPKqYTLcimCNyBLv8W1eCi7Uw4uFNpc/dMv+CYCC
	 CVoLw+TLMa1QRZb865WIgSmhQ/GbXpmwqBEHMB/oxTWtJ0og94z5JTbplpEd5GbBOUS5B
	 LyliA+smHXfucrBT3mBaCXHZFvYp8UdjVo620q7hnwv+MVKHspeHPfPCZ/jgw4VNdGp4x
	 HqIHFOW/n1gaBaaszvBtc13G11/4Ag3d1qZGQx1g75VlT8f3Wfa0RijR1PMl2BuIYZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lniW42G6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DA3606A31C
	for <linux-watchdog@vger.kernel.org>; Wed, 18 Nov 2026 09:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lniW42G6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 203761F000C4;
	Wed, 18 Nov 2026 09:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794994097;
	bh=3ZsQ1RQW9HsIzrN77N2oVBaxnZKiAj1l1ATVrYAyRQA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lniW42G6GkmMS+S+nE+V6Z7zBC3SontUElnClQsgbNoJWwf0E4sMiXfxwV13HuCg6
	 lCuDTF8BsGPv12vF6YhXvjYQpCW1gu6OvLeAwLK7r6Fv6YCumDYcs+80D/5rIO5BOK
	 UPmCXCunB/YbzKbFZAbJtpCGCpEkzD9OSMdWTIbF/rH1o3ZyHP/0bbbDkESwEsZCyV
	 xfk0/QGgNOYAft5Ge5cq0T1OhRmQ9nnEL0J0AJKDPNYqqfifyLD3GhOOspIpcuJsCu
	 3+umQ/FXUQDchq6CDYzvvRoEMbD1Wcw9DE7LHCKj0+udU1PU7gSx/fplAUQS0ZnL7E
	 sH7Tra3uiQyAA==
Message-ID: <sashiko-outbox-220559@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 1/2] RISC-V: Add defines for the RISC-V SBI
 watchdog extension
Reply-To: sashiko-reviews@lists.linux.dev
To: "Prajwal N" <prajwal.n@oss.qualcomm.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20261118092147.2017658-2-prajwal.n@oss.qualcomm.com>
References: <20261118092147.2017658-1-prajwal.n@oss.qualcomm.com>
 <20261118092147.2017658-2-prajwal.n@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 09:28:16 +0000
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] riscv: sbi: inconsistent WDT vs WATCHDOG naming in asm/sbi.h
--

commit 2382be713df4d02db88ea32a1b310d27210f00eb
Author: Prajwal N <prajwal.n@oss.qualcomm.com>

RISC-V: Add defines for the RISC-V SBI watchdog extension

This commit adds the extension ID, function IDs, and attribute IDs for the
RISC-V SBI watchdog extension.

> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index fd6266a7b3395..f2b0b0c9f6b13 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -40,6 +40,7 @@ enum sbi_ext_id {
>  	SBI_EXT_FWFT =3D 0x46574654,
>  	SBI_EXT_MPXY =3D 0x4D505859,
>  	SBI_EXT_DBTR =3D 0x44425452,
> +	SBI_EXT_WDT =3D 0x574454,
> =20
>  	/* Experimentals extensions must lie within this range */
>  	SBI_EXT_EXPERIMENTAL_START =3D 0x08000000,
> @@ -536,6 +537,31 @@ union sbi_dbtr_shmem_entry {
>  	struct sbi_dbtr_id_msg id;
>  };
> =20
> +/* SBI watchdog function IDs */
> +enum sbi_ext_wdt_fid {
> +	SBI_EXT_WATCHDOG_READ_ATTRIBUTE =3D 0,
> +	SBI_EXT_WATCHDOG_WRITE_ATTRIBUTE,
> +	SBI_EXT_WATCHDOG_WRITE_NOTIF_MSI_MESSAGE,
> +	SBI_EXT_WATCHDOG_START,
> +	SBI_EXT_WATCHDOG_STOP,
> +	SBI_EXT_WATCHDOG_PAT,
> +};
> +
> +/* SBI watchdog attributes */
> +enum sbi_ext_wdt_attribute_id {
> +	SBI_WATCHDOG_CAPABILITY			=3D 0x00000000,
> +	SBI_WATCHDOG_STATE			=3D 0x00000001,
> +	SBI_WATCHDOG_MIN_PERIOD			=3D 0x00000002,
> +	SBI_WATCHDOG_PERIOD			=3D 0x00000003,
> +	SBI_WATCHDOG_TIME_LEFT			=3D 0x00000004,
> +	SBI_WATCHDOG_NOTIF_TIME			=3D 0x00000005,
> +	SBI_WATCHDOG_NOTIF_MSI_ADDR_LOW		=3D 0x00000006,
> +	SBI_WATCHDOG_NOTIF_MSI_ADDR_HIGH	=3D 0x00000007,
> +	SBI_WATCHDOG_NOTIF_MSI_DATA		=3D 0x00000008,
> +	SBI_WATCHDOG_ATTR_MAX			=3D 0x00000009,
> +	SBI_WATCHDOG_ATTR_RESERVED_MAX		=3D 0xFFFFFFFF
> +};

[Severity: Low]
This isn't a bug, but the extension ID (SBI_EXT_WDT) and enum types
(sbi_ext_wdt_fid and sbi_ext_wdt_attribute_id) use WDT while the
enumerators inside those enums use WATCHDOG (SBI_EXT_WATCHDOG_* and
SBI_WATCHDOG_*).  Other extensions in this header use the same acronym
across the extension ID, enum types, and enumerators; should these
enumerators use SBI_EXT_WDT_* and SBI_WDT_* for consistency?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118092147.2017=
658-1-prajwal.n@oss.qualcomm.com?part=3D1
