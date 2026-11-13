Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794572865;
	b=OWHhLI3iyj7iH4FnXulNl46UJcGGKHA3a6tqC+tqmoBKjRBvpAxW2w9Bx/f3sjZe/VE/
	 OymsyNuX8LP049TxIuRu7boe8r9YUUzM45RCralc/WXPXmoFmbztdnA4hnWGD0jit3xXL
	 vHTWMSqlhviIuDodicI5Mo/OLuOLAOIY2GXIxyX11rpm/c3+Dc7bveRkxrXRiK01Yk2X+
	 ys/yoGzYtuIC5grWrrov/8hlYuE5tvRGH+6z5w/rxbFjkUihuDfn9hKdwWEWo87qsfzdI
	 hjGB8qr6W2qFoRBCj/SVYIPO+/eEKG9vduDQaFmdWZT0G6S35GXBuYaIGZhpLBBB2+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794572865;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=cPdbPf3O0dB3cGFQ8sK6rQpQ9lLWjI1P/THDz6RTp4o=;
	b=zB4YA3riCXUb7MnW1Bgro/vBmRrfA1YevRdNK2/uI81mBEnrein+V4mF+MmEimeT35WZ
	 vQl92LfLrEbLexmtdYIKtZtFXwCyTAsi+Io/FQxVYFqwy6gOl12UpvemMhLQQ1Eta4uxy
	 fKyT6imA3RvxTt2BCI2Xlf6cfxmBZjIMm3tGCwUmDMg7DTUQQ+CVxD/HEl+KFbmAg+U4Z
	 IckGVRJm6Ba8cS2Ggb8ajjMuLk0IlVKtNIfBXUZqFH54WG38Ks2gMUsL4NihcdpgiRRnZ
	 4Ncs/STh9AwD+sE8WX4LvISpSRv03NQiyYV9CpI1FJ35lNVf3XbjyVGYlVLmtLtwgqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=meEBToih;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8E7606A327
	for <linux-watchdog@vger.kernel.org>; Fri, 13 Nov 2026 12:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=meEBToih
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 398511F000CA;
	Fri, 13 Nov 2026 12:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794572865;
	bh=cPdbPf3O0dB3cGFQ8sK6rQpQ9lLWjI1P/THDz6RTp4o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=meEBToihuHCshG+K74DyAzWVbP60D1HC6ypl5NGz24hMSMjOqPY421eh6qpC+QIYT
	 As7y2EHu3UGMJTCMvxnNO/0ycV7+g8eQsKW0wPnzA8Zg9xUiRiJDY+BcmX/rTGcuj5
	 GW2ePjJQaMaFXTlguvrR6MbhYEIjCnqBJjbr+LvKiPz8vQdhqXQ8qE3Ik2/gPgScYy
	 4u44/PNO70Eg+7gCsrx3o7rQKx1yyc3qCGOCCfH+u5v02WtD7cFvDfRTWtHAWRM3HB
	 iAkyWJwO1FgJWef9FNze+dpXWlJ3Q7imMWISKoKV7lTmIn1dOmk8BOpqU1LlPerEA3
	 f6en1oWlnLq+A==
Message-ID: <sashiko-outbox-212758@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 1/2] include: sbi_ecall_interface: Add defines
 for the RISC-V SBI watchdog extension
Reply-To: sashiko-reviews@lists.linux.dev
To: "Prajwal N" <prajwal.n@oss.qualcomm.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20261113121857.1640918-2-prajwal.n@oss.qualcomm.com>
References: <20261113121857.1640918-1-prajwal.n@oss.qualcomm.com>
 <20261113121857.1640918-2-prajwal.n@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 12:27:44 +0000
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Low] riscv: sbi: commit subject uses OpenSBI sbi_ecall_interface
  prefix
- [Low] riscv: sbi: inconsistent WDT vs WATCHDOG naming in asm/sbi.h
--

commit 20a1be6707ce97918704c1778e1e39d1a180ed16
Author: Prajwal N <prajwal.n@oss.qualcomm.com>

include: sbi_ecall_interface: Add defines for the RISC-V SBI watchdog exten=
sion

This commit adds the extension ID, function IDs, and attribute IDs for
the RISC-V SBI watchdog extension to arch/riscv/include/asm/sbi.h.

> include: sbi_ecall_interface: Add defines for the RISC-V SBI watchdog ext=
ension

[Severity: Low]
The subject prefix "include: sbi_ecall_interface:" refers to OpenSBI's
include/sbi/sbi_ecall_interface.h header rather than a Linux kernel path
or subsystem.  Should this use "riscv: sbi:" or "RISC-V:" like other
commits touching arch/riscv/include/asm/sbi.h?

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
The extension ID is SBI_EXT_WDT and the enum types are sbi_ext_wdt_fid
and sbi_ext_wdt_attribute_id, whereas the enumerators use
SBI_EXT_WATCHDOG_* and SBI_WATCHDOG_*.  Other extensions in this header
use a single extension acronym across the extension ID, enum types, and
enumerators; should these enumerators use SBI_EXT_WDT_* and SBI_WDT_* for
consistency?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113121857.1640=
918-1-prajwal.n@oss.qualcomm.com?part=3D1
