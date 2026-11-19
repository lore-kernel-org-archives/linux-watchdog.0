Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795100479;
	b=vEkKdhRoi1rB1MODNzQpvmaU0bcxPGg2LMiNCPiqstzSqKEgo9E6rUaJkM702Fvcy1ZT
	 ralb2aYI7OrOIDnb3b3YE69LfzBGG4zGlf1iICWiyZXEyAzfXhTVaBkAwOZ3i9n2I9699
	 LYnnwrAw5i2k1d0WYBlzANw/ScZr9Clr0I6ycO0Qa+/gL77U2hQgJ22iwEkQeuSymr2Z8
	 9+MZgw+zTum09nrFdBezpg/GBWPSw7ZIb3AvKHZT5yw0ZUQNMMc+YWFLrqMkhCh+ShnwZ
	 pTbgkzP6rBpyFxFiME5lBe+L4szvFQAtld50NatKXlLCXjcLvXtBA5z67ogQvHqaYMg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795100479;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=RnqHNzlTcadbdRnn6+q/pLt5ZICBBqMuBrJP4IdL8vQ=;
	b=UOn3xoDKTYpJw8kFq58lIpJGUJktlWXWYDiRlHrf9sMhgb1rZhM2fHIuSrZ85e302wQe
	 zYzrGHQGofE7g/E/F1QLCywRbfaQTZyhSFlTcOB8q/PENbyM/NTsc56zI8pN00mkMe/QK
	 F8rKwY97YWaAwN4WmnVDkRmBXHlQRjZ4B3FNBDqwnqZeD7YT8+jxppQGly0dh9asjSzeC
	 2m1hzGMrM6BGO8AfrzEfUqyy5ik9EM7DLysqrmN5Pr6QONRNMIFWBET+u9BswhKPSWVff
	 g69VU1uKO6WfWgDwmu5BI4iH45K44X8S5GqNoMMlZsYlo8JkICQTsoV5ymrWbOoP9iw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=brainfault.org;
	spf=none smtp.mailfrom=brainfault.org;
	dkim=pass header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b="D/nPHEop";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4193606A326
	for <linux-watchdog@vger.kernel.org>; Thu, 19 Nov 2026 15:01:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4193606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=D/nPHEop
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4bb70074ab2so24988405e9.0
        for <linux-watchdog@vger.kernel.org>; Thu, 19 Nov 2026 07:01:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795100477; cv=none;
        d=google.com; s=arc-20260327;
        b=E6KC31x7NMqQKFaLZgQPtHqxkVq0MrkGbxUqaAjTdQbigWwrz+iLKaeWHMLySaBw+X
         4S+1S9LcEWF//yHRi7soNfXn03PBWi+R4R/H1eNcJ4LTOErSHvHGsCNq+FO273lL2UxZ
         G3ILlmfIUlrV1btklKLEThuLYxATrIDMjXB4F6D0qlQVa+UF3vddOUiPIhVI82CmZMCn
         pJJeeyYe0ITYjoZTkYC/gy+aUfo9VUupNwuX95wjXOuuT6gKcQvYvEa1A1k6Cw6mtHYI
         vogiM8pTJ5Nlx1zE0jwPGPPwZOmaJo0Zn64+cshe043/QTejbd4rDW+GxUO0Y8mH0j2H
         ra5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RnqHNzlTcadbdRnn6+q/pLt5ZICBBqMuBrJP4IdL8vQ=;
        fh=MWUT8bAdoTtIe1uNw0+Rx/4ftYYTwl4l5DGScWM0Mlc=;
        b=O04zgGNjtRuAvoju/ALjj4bh03ZEvchId3LOIgMzt8tOBC/3430ZoTuY4aBwFjQwGv
         Yj3HkTcsSp0QR8DMyoDFOsLDf/P7TdTGm1/9f8cMS2gxcF5E6xCczx013s4yQnkh4LuE
         LoHjxhb/fyJjUEtouke20jBtLZg+0+ajhQ3talREdhvyKIc+Q3Xc6HtIqguJkRqIYt9A
         1hlNZdefdgVH2hsxaOVRx2IlVuyWXktdRVRi9xP5x9sLbUloRIdjIh5/7UOGO5Zn2BRS
         58PHS8srAaMnkGOe15mJJkXEpTTz61CQWd+qeAY5DVTCnI/pkHhg9rBecFg0uvFIo0be
         Vq3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1795100477; x=1795705277; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RnqHNzlTcadbdRnn6+q/pLt5ZICBBqMuBrJP4IdL8vQ=;
        b=D/nPHEopkmwaNoK22EHwJE6qfKU/+73uaL4rKHAuknDM7reQTmGIX34tUHtE7hQWLi
         /AvT7LczIoWrVJguvJbS49k/Vu5l3U7ETysBt40c6cfrFFJHhivfvi3qiFqR5FriR03l
         xG9IGaP3YhUxm6O5jmfaw5SbFWxCjP0ISfQQMUKr1zG+J0wYngZWDYnZQdr/Lvc40Y7p
         2GwdRO3QIqsrI8Cl4vWQKrweVFuqF+30fWunC+q3EMx9KrauNl6LuLN2UsDSIdu3EC1j
         7ajbtFVJOzkrVybSZgrv4ZsbDMhTd/Vp1JdBITC1CPt6ua6TiwQMiewsKJ7I1LTpXqil
         VvOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795100477; x=1795705277;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RnqHNzlTcadbdRnn6+q/pLt5ZICBBqMuBrJP4IdL8vQ=;
        b=w2JtVxjrNrPwwvZzZLIwswVExKeY/B/nyyk075dY6zqvBMmmkTxwjUj3cb4ZC5873l
         w69LBRKvD9AYfui6s1HSYrk7qtxMeHuafuvohrniUDZEdwIqODstfQZv9mD+iHufF/W4
         Myjxengmj+x9FAse9fKRgNBVEsoTTFu7e7zw0/Fy28/qY6OsLTuG9j82tGLaT8WC/HQg
         YSjwMv5KlAFeZnDvNHoZdSz80kT/e0PMsWWnBEWPyLEG6I28sfWTxYOcipIhP7s0Er7m
         31X9zwKti4eCT0f3Nhx2gGtl0Iux3wOjHIQWKiPOFRd4GRF/vYQsEdw3As0ozFoTcvGK
         Bzww==
X-Forwarded-Encrypted: i=1; AL+hErFiUkLATrb4O1S3Q6VmWTqYl9hAiWYtOcln0rJTd4ixu3hzZd935TNKzi8tpnmHC/uFifCIXIWxhVa5adiGzA==@vger.kernel.org
X-Gm-Message-State: APuU4Z87VSkHNKEWk3BZtx7MuvFWAo08/FjEtf0j1mNBmGlsa+F3CSC5
	1jD2l7suGp7g8ETcBiw3Pjng69beFGwDZgViy2I3jjfaaSPScqB5mQaB6ZC7Yh28vD4MKCWHiuO
	11d/zWz2fPtY4eAIFILxd+tF532GdLmDdp1Np6c1RQA==
X-Gm-Gg: AYBFou2+dyj4Vm3iWbfIYpWyLGxIanI2/x4t27SFOs8E3hlsgmLIiRzRGnU+JSfX4qa
	EpFLO3Mla0t4qnL6bC1OGcPeRToO06jB+yWcApMmwiWj17NVfhuKfzAXHowqOi2EmTU3pl9oXw8
	VnSolIt0rzdL/Fcrn7VQsQujcxl03n0ewJJdmbA7hwrlP3bkhl9URqSnO+XojWjcg4oYBS146ZL
	CeDIkCuheaECBoMcOE6pQrvDlqCB+DOE5VdBB1D4qAohfA2gWHp7bqxBrcxX9SKa2wxcPtOOABh
	I/wI/hkcpRYwZiWzBkSzr3rjEMfSXTukpukBLzFHA9XXmfudADGfr79zNvbpQD7AmNreanF0UDD
	CjXDFaBUrxUumzmuPslyilPKHyT3YG5U7ewqwuznJtEE5a2B9C6Q4x8pD0TTFdWhNdPoUfBV94S
	jH6b/S56rIB1YHTliTAb+lORyBt5s1U8zX2tfhx9Mex3vco2q0gm4Lxpl1
X-Received: by 2002:a05:600c:19d2:b0:4a7:c366:d791 with SMTP id
 5b1f17b1804b1-4bb7d6cc14amr126502605e9.1.1795100477039; Thu, 19 Nov 2026
 07:01:17 -0800 (PST)
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261118092147.2017658-1-prajwal.n@oss.qualcomm.com> <20261118092147.2017658-2-prajwal.n@oss.qualcomm.com>
In-Reply-To: <20261118092147.2017658-2-prajwal.n@oss.qualcomm.com>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 19 Nov 2026 20:31:03 +0530
X-Gm-Features: Aa3M54pqdSyMpxAUEyGq383herjDzFKNCIiZY_1f2mIpsmKm3yMLScXr3WzE5ZM
Message-ID: <CAAhSdy2zvLE51Ttn-=Z=7B_UY_dOD-a2RCLCwCsFp+KsB9=jDw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 1/2] RISC-V: Add defines for the RISC-V SBI
 watchdog extension
To: Prajwal N <prajwal.n@oss.qualcomm.com>
Cc: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	wim@linux-watchdog.org, linux@roeck-us.net, radim.krcmar@oss.qualcomm.com, 
	anup.patel@oss.qualcomm.com, linux-riscv@lists.infradead.org, 
	linux-watchdog@vger.kernel.org, prajwal.n.oss@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2026 at 2:52=E2=80=AFPM Prajwal N <prajwal.n@oss.qualcomm.c=
om> wrote:
>
> Add the SBI watchdog extension ID and function IDs for supported
> operations, including start, stop, pat, and attribute read and write.
>
> Define the attribute IDs exposed by the SBI watchdog extension, including
> watchdog capabilities such as MSI support and configurable watchdog
> parameters.
>
> Signed-off-by: Prajwal N <prajwal.n@oss.qualcomm.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/riscv/include/asm/sbi.h | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index fd6266a7b339..f2b0b0c9f6b1 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -40,6 +40,7 @@ enum sbi_ext_id {
>         SBI_EXT_FWFT =3D 0x46574654,
>         SBI_EXT_MPXY =3D 0x4D505859,
>         SBI_EXT_DBTR =3D 0x44425452,
> +       SBI_EXT_WDT =3D 0x574454,
>
>         /* Experimentals extensions must lie within this range */
>         SBI_EXT_EXPERIMENTAL_START =3D 0x08000000,
> @@ -536,6 +537,31 @@ union sbi_dbtr_shmem_entry {
>         struct sbi_dbtr_id_msg id;
>  };
>
> +/* SBI watchdog function IDs */
> +enum sbi_ext_wdt_fid {
> +       SBI_EXT_WATCHDOG_READ_ATTRIBUTE =3D 0,
> +       SBI_EXT_WATCHDOG_WRITE_ATTRIBUTE,
> +       SBI_EXT_WATCHDOG_WRITE_NOTIF_MSI_MESSAGE,
> +       SBI_EXT_WATCHDOG_START,
> +       SBI_EXT_WATCHDOG_STOP,
> +       SBI_EXT_WATCHDOG_PAT,
> +};
> +
> +/* SBI watchdog attributes */
> +enum sbi_ext_wdt_attribute_id {
> +       SBI_WATCHDOG_CAPABILITY                 =3D 0x00000000,
> +       SBI_WATCHDOG_STATE                      =3D 0x00000001,
> +       SBI_WATCHDOG_MIN_PERIOD                 =3D 0x00000002,
> +       SBI_WATCHDOG_PERIOD                     =3D 0x00000003,
> +       SBI_WATCHDOG_TIME_LEFT                  =3D 0x00000004,
> +       SBI_WATCHDOG_NOTIF_TIME                 =3D 0x00000005,
> +       SBI_WATCHDOG_NOTIF_MSI_ADDR_LOW         =3D 0x00000006,
> +       SBI_WATCHDOG_NOTIF_MSI_ADDR_HIGH        =3D 0x00000007,
> +       SBI_WATCHDOG_NOTIF_MSI_DATA             =3D 0x00000008,
> +       SBI_WATCHDOG_ATTR_MAX                   =3D 0x00000009,
> +       SBI_WATCHDOG_ATTR_RESERVED_MAX          =3D 0xFFFFFFFF
> +};
> +
>  /* SBI spec version fields */
>  #define SBI_SPEC_VERSION_DEFAULT       0x1
>  #define SBI_SPEC_VERSION_MAJOR_SHIFT   24
> --
> 2.43.0
>
