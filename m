Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795526467;
	b=Mlit3B8ZMKdoW6S3fxVsjBL4m2H1mPysfrykqT2tqJVeKESXsAH+yBwG8aMOlYNIXYwZ
	 AXMhhTwHTo2a8Ol8KRcdl6QWPRP8nMw9zUw0fBKc6A4Co8pQ1uZwV3SsCd887OLJcQTVK
	 IqU1n/QTaPOvBiQ7uomU/w0amuVAAS6mK/+vGkMhjw44CAaiqdBDzx9+DLlm3YPkx2svQ
	 V/CJsV8KXulUJ17TstvAp2dQ7U1d3JW9v/PdfTZldl6bQdi+9EDl4Gp0X40yZ8hFzCygx
	 /qRxBjI1JxgxNfH0pTdUxy/XGRH9mlEImQVQ2TdQZ3AJKoGH1sPlstF/cLJvCZ6tRnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795526467;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+iSVu8qqF/88Gntq+d1NmCdy+CfilI+U+uaEh9W3mRM=;
	b=fL6ip+1VdHYnNv5eZP0bhbaz01VYJka5f/EJwYAbo7gtKQbj/UNL/FPRh1j+4rtZ6Fy8
	 GHdI+AIJ80hUuBm7OG1zarMZoct+uBbk/WzwWPcksfYfU/Szq3ZjiqrmaLgegdD/GAX36
	 iploWzyRfUlP1adJ+AUaHehw7x3bJdwXfBK+dl5o/6soLJe7Z0w43iFsJMKhQnz4E7XPh
	 oDF5D8Csk44dfx7ICq77R0mQ+sq5MR35Qed2fHl8s3wvtY+APNE5pC0+Li3fQ31ixYL9n
	 TjAoS81cumHCG8TazrcE59yrolg9Dio9e+TSQq7RFdAamKyyTkGR3SbL/KkXQhCH4uA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pn9zYKYU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9679606A326
	for <linux-watchdog@vger.kernel.org>; Tue, 24 Nov 2026 13:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pn9zYKYU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A6531F000ED;
	Tue, 24 Nov 2026 13:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795526467;
	bh=+iSVu8qqF/88Gntq+d1NmCdy+CfilI+U+uaEh9W3mRM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Pn9zYKYUtfelFf4nC6hrxH3A+7A0Z0edlczvUZX6KHX2HGayyJfFgaNG6fEzjxOD0
	 BNdw8cRedKq0mYSU2MfOV78bYNgteRSWZK1oXOpQqH+fbBi9toTJqlvvZzROEL8Hh5
	 DtHqxwvIHEnMgR1zA8qRzyT7onYpxl92TcYLAqCSsqpHukNbB9nyjJDlsSi/q4si5v
	 BfQEi+afrABoD83Af85WNnzRZm9RrSISWg/CgfWd3L0RO4TPhrCMmNj5chdKu4Dc42
	 DhQC6FdV42X4jNRnTMzINLxO75o6q3bsbyVWLSkofVFr7xyiojEBKQqJgqhDszchIj
	 aOdciOpJzfPLg==
Message-ID: <sashiko-outbox-231195@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v4 1/2] RISC-V: Add defines for the RISC-V SBI
 watchdog extension
Reply-To: sashiko-reviews@lists.linux.dev
To: "Prajwal N" <prajwal.n@oss.qualcomm.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20261124131542.613271-2-prajwal.n@oss.qualcomm.com>
References: <20261124131542.613271-1-prajwal.n@oss.qualcomm.com>
 <20261124131542.613271-2-prajwal.n@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 13:21:06 +0000
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

commit 0a75cf9d3428dfcabb80b08ac219176e7b70a095
Author: Prajwal N <prajwal.n@oss.qualcomm.com>

RISC-V: Add defines for the RISC-V SBI watchdog extension

This commit adds the extension ID, function IDs, and attribute IDs for the
RISC-V SBI watchdog extension to arch/riscv/include/asm/sbi.h.

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
This isn't a bug, but the other extensions in asm/sbi.h use the same
acronym across SBI_EXT_<EXT>, enum sbi_ext_<ext>_fid, SBI_EXT_<EXT>_*, and
SBI_<EXT>_*.  Here the extension ID and enum names use WDT / wdt while the
enumerators use SBI_EXT_WATCHDOG_* and SBI_WATCHDOG_* instead of
SBI_EXT_WDT_* and SBI_WDT_*.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124131542.6132=
71-1-prajwal.n@oss.qualcomm.com?part=3D1
