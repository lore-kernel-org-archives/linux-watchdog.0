Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76AD46C4C5
	for <linux-watchdog@vger.kernel.org>; Mon, 31 Aug 2026 18:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788200243; cv=none; b=f5vtmuiaxStQOjMpcR+/J4J+CkhTneJuavCvxV0XJ0bk8nEqgnp0CIn8C1ayzAjyOMzHc/gVLXJF5iozTIcHyFKTAFrbKI3zkL03UfbHQefC65lojqrMZ6aroshVdNMsjf42ksmHomgumsRZYOd6gIJ2fkg8m+WNBzKGHPCIKkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788200243; c=relaxed/simple;
	bh=3mzJyxDJT2mp+IdJIQ9y9rYao24CZqxfqF2rh8sEaCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S379FhIacgSQh3skHzP5UHoxLIqWrdXpw4yQrr+G834Q+XcZ1gmDkY6YjtRhVPiXvNwCe7QBYJ0yAJUGbANV52koKLdFF4jlm+wvp4arNby1a17WmE66M9m/Xav2KyzLqo2q23RF1yI7mqkPowrRxppUOU6dlNd5sNpqTWUvU4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aLI6+deT; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aLI6+deT"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c160420289bso500024266b.0
        for <linux-watchdog@vger.kernel.org>; Mon, 31 Aug 2026 11:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1788200240; x=1788805040; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UH4ANZUDTinUoNy1nGt6KAwdPIsDwQv9pXQSAcw0TmU=;
        b=aLI6+deT9yxbMcxOsbPtko8Ds5NYDYzRclavdabOpXeIwSqnZuH5q6z6kiA2YIY6PK
         VMdtUJTAYBSJe1gcRo4WhRCm3AkqRoQ6EcTOlFh8d++WYMK/pO4LaZvCUxw8OjyKYiDL
         hGU1U5a65kl7JUE7RucvzlYNMZbiuvWAjSDss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788200240; x=1788805040;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UH4ANZUDTinUoNy1nGt6KAwdPIsDwQv9pXQSAcw0TmU=;
        b=oDz0gwSVcW+M7+BidBg5V9foxT2D0B71oSiJMhodePs3wwBUIL+u+Kr1LUB000qgP9
         gWXyUdh2xQqQztKLqs3Dr6f7ara4/pxnFaaHTMiYy1mZCP0Qb1J3uJ7DQ0L/LYjCF5Px
         TdJRAZrWyzYcyqFu1qzHRM8Jevlev6roCIzJ2EyE7eH0IIkD1lSM4WpyhDRZ6PgPNfad
         zdtfXiB8Yn1Fl/FmgOhIp9Bp8Rpj3t4V7cNUCSmLeRKX4GNCs0c8V2Z9cPUVmj46nMKT
         RLXWLNkSWly6o/gR90J47aCLL1Aja/uHqaDe6ONHnFsnrPm6BbuB52gctr2GCwvjzEAp
         3bqw==
X-Forwarded-Encrypted: i=1; AHgh+RorYG46MUAiUtJXXTSm+lbwoFS5ZvHFLyX0URAGb+plqbZQSvvIfHKkAodvviJ85AY2T057PDqx3M7c2AyDxg==@vger.kernel.org
X-Gm-Message-State: AFuF++mLhIi/F1b9Xk0drDZ1K0CVQDvHwsirM3KSLUwYzmVviF7BQr4t
	WmrORsJ0SHgPWZVvBpxCpNLhofYtVhZJI8izMHroqzp5qkBobicp14g1rw87Y/rF64nOLVEIyo1
	ZbdtGyi76
X-Gm-Gg: AYBFou35O2L98LrBnWCHUk9oyBIMMOlhy/1u4Bqh9h3D2P5uxj6S87BoPH7NmnSiwld
	a7mLLDTOtejb0jFJFHZvD9dlRpj9ZLFSmn1ay49AfSM+E3CrwOSA7OLGNkDuBAGtBXMzbOQHtd+
	aBMeqfgUy0ToiEt39+Iu/6/POBXNv/Ylq2Q/6XoBOah/E795YkGqSy1iQ5PHOMgCcEiHY0Ebuzj
	zs2ZHhVWdhgus5u0EG/Ys/WYKq1PJhO+6JpFEx5JCp8g/9ld0zRNwGWAm6WYV/uRk5s3/LZ8DD1
	xJeTKhgUnm3UdSF2eidra3uVu85gZx+0a0A5xTv+AivQBOZRJBkq+L4oikSzv7Kck7ffSjftPGb
	ApSN47GQ8pW7AkPjWyAIC6CCwP9X46/HxSpZpMoj88jX54BYpJAJQE5Wk8KOXkspg6CjMhj7X0g
	Xwlzbke2R88tg4omzN4CTSYQqzco+t/77w7UMAAgsH9daEKUmB7BNZshxLTzpWNA6vUJa/z4w5p
	WlEHxE4C+LSvWr4shp2gRRczVY=
X-Received: by 2002:a17:907:3d56:b0:c25:47a4:fedc with SMTP id a640c23a62f3a-c25b3bb9089mr148621266b.2.1788200239958;
        Mon, 31 Aug 2026 11:17:19 -0700 (PDT)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c255f1b2049sm487476366b.36.2026.08.31.11.17.19
        for <linux-watchdog@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 11:17:19 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-484362f5c4aso1591532f8f.3
        for <linux-watchdog@vger.kernel.org>; Mon, 31 Aug 2026 11:17:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxRkWOcJd8TlZxncuEk3dqaIuWucaadU95c4IHeRN85B6+jHYJUqlo5jEGXEvKU6me90ZceoBmty0jr1Uso8g==@vger.kernel.org
X-Received: by 2002:a5d:4d09:0:b0:482:a9d7:7ced with SMTP id
 ffacd0b85a97d-48441011572mr4215421f8f.14.1788200238138; Mon, 31 Aug 2026
 11:17:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260828-qcom-wdt-nmi-series-v2-0-363979fe6b6b@google.com> <20260828-qcom-wdt-nmi-series-v2-3-363979fe6b6b@google.com>
In-Reply-To: <20260828-qcom-wdt-nmi-series-v2-3-363979fe6b6b@google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 31 Aug 2026 11:17:05 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X4NB7nBqtfVQeoubc7wjS0n2nkfez+Yyby53yO39Kz-Q@mail.gmail.com>
X-Gm-Features: AcwNN1U3FPvHmoemFs05LjwC8xqc8xl7PGyosbmesgJCRaLsNeUN_OaM3dBYevE
Message-ID: <CAD=FV=X4NB7nBqtfVQeoubc7wjS0n2nkfez+Yyby53yO39Kz-Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] genirq: Export NMI APIs
To: Mayank Rungta <mrungta@google.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, linux-watchdog@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	"Kirill A. Shutemov" <kas@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Aug 28, 2026 at 6:00=E2=80=AFPM Mayank Rungta <mrungta@google.com> =
wrote:
>
> Currently, request_nmi(), free_nmi(), enable_nmi(), disable_nmi_nosync(),
> and disable_nmi() are restricted to built-in kernel code because they are
> not exported.
>
> Export these symbols with EXPORT_SYMBOL_GPL so loadable kernel modules ca=
n
> register and manage NMIs.
>
> Assisted-by: Antigravity:gemini
> Signed-off-by: Mayank Rungta <mrungta@google.com>
> ---
>  kernel/irq/manage.c | 5 +++++
>  1 file changed, 5 insertions(+)

This is no different than v1, so you probably should have carried my
Reviewed-by tag:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Sashiko has feedback [1], but it seems to be mostly regugitating the
same feedback it had on patch #1. It also mentions that "`free_nmi()`
ignores the provided `dev_id` parameter", but (to me) that doesn't
seem like a big deal and is certainly not new.

[1] https://lore.kernel.org/all/20260829011550.ECF091F000E9@smtp.kernel.org=
/
