Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54FC375F97
	for <linux-watchdog@vger.kernel.org>; Sat,  3 Oct 2026 01:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790991199; cv=none; b=gPTNpC2IOC/O+75shUL20Kd5Iq/GdAkoLKbRPbIF2R0YFLDgJG1sZ1FkdNGt3CZ4BW3Bi4n33nruwXpeGkgkcRqvUm5E8wDnTt013kBkmElrnXekB34/aJkYQMmbuuvtvIHNwe4ZH7KxxCBs31YAntIhmMcFwvrg8j8UgBF3+U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790991199; c=relaxed/simple;
	bh=+aoLbBRhTqpjPm2XTI3CMOgPlXlgNqAo6CjrTFj1T70=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V9TZU3+wrUB/h22FXixzv7aGv79/IWWVEYdEu0qJpP05hlQR7oZwnaHAKxl+ixXTnyCWruahrYSY05soLDOfatS47rpDVGfX6tPyYsSFsh6CpJC7gw8NclbP5BFWwR7pEosRbwnedc1PHonIjD7fKIJwOry6yQymu+bou2U/1w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nDZGd1TD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nDZGd1TD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BE561F00893;
	Sat,  3 Oct 2026 01:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790991198;
	bh=BkcNJglBAlVA1fXiFVfd5PkIoqPqMVetVpZ5uQGHDdk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nDZGd1TDJZm4nfHTrMqZbejuYRuJS3tMyUYIkfXdxxaBLgE3qO0qVoM4p/qOvxQiS
	 m0ahhO7O8zF4KZNEPknxZDeNGyVn9KgpazmRK85khIWOaVTC7D3lo1jceKadLOer9a
	 A+E1JG7VqjitrNMUFaRuVSWACcc+qJ97eL85E/haYaow9I1uN+oLZi9N1YOm4t9ghw
	 FCi2e+Lic5hEePWtuCl7GP8GmvnpYrz0h8ZV6CUSQajVl2/4R7pBIfmN+GSWTmdccA
	 83JcfIh9k2SUwnQ2odk9qqkFF0C5olpRikSQMs7AzB1ClPHbjyCl6Cp2zVd7A49v5z
	 jkcX9du1Cx4JA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/2] include: sbi_ecall_interface: Add defines for
 the RISC-V SBI watchdog extension
Reply-To: sashiko-reviews@lists.linux.dev
To: "Prajwal N" <prajwal.n@oss.qualcomm.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20261002163758.2919372-2-prajwal.n@oss.qualcomm.com>
References: <20261002163758.2919372-1-prajwal.n@oss.qualcomm.com>
 <20261002163758.2919372-2-prajwal.n@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 01:33:17 +0000
Message-Id: <20261003013318.5BE561F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] riscv: sbi: overly generic enum name for watchdog attributes
- [Low] riscv: sbi: inconsistent prefixing for watchdog function IDs
--

commit 7817ac6d29fdb82db2284ee376b8c224893e23e3
Author: Prajwal N <prajwal.n@oss.qualcomm.com>

include: sbi_ecall_interface: Add defines for the RISC-V SBI watchdog exten=
sion

This commit adds the SBI watchdog extension ID, function IDs, and attribute
IDs. It enables supported operations like start, stop, and attribute
read/write.

> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index 5725e0ca4dda3..b67ee507c517e 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h

[ ... ]

> @@ -534,6 +535,31 @@ union sbi_dbtr_shmem_entry {
>  	struct sbi_dbtr_id_msg id;
>  };
> =20
> +/* SBI watchdog function IDs */
> +enum sbi_ext_wdt_fid {
> +	SBI_EXT_WATCHDOG_READ_ATTRIBUTE =3D 0,
> +	SBI_EXT_WATCHDOG_WRITE_ATTRIBUTE,
> +	SBI_EXT_WATCHDOG_WRITE_NOTIF_MSI_MESSAGE,

[Severity: Low]
Is this prefix inconsistent? The extension is defined as SBI_EXT_WDT and the
attributes use SBI_WDT_. Could these function IDs use the SBI_EXT_WDT_ pref=
ix
instead of SBI_EXT_WATCHDOG_?

> +	SBI_EXT_WATCHDOG_START,
> +	SBI_EXT_WATCHDOG_STOP,
> +	SBI_EXT_WATCHDOG_PAT,
> +};
> +
> +/* SBI watchdog attributes */
> +enum sbi_ext_attribute_id {

[Severity: Low]
Does this generic enum name risk namespace collisions with future SBI
extensions? Should it be named sbi_ext_wdt_attribute_id to reflect the
WDT-specific values it contains?

> +	SBI_WDT_CAPABILITY		=3D 0x00000000,
> +	SBI_WDT_STATE			=3D 0x00000001,
> +	SBI_WDT_MIN_PERIOD		=3D 0x00000002,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002163758.2919=
372-1-prajwal.n@oss.qualcomm.com?part=3D1
