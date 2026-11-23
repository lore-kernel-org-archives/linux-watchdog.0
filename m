Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795476522;
	b=21peAfGBd5rWmS2ocFvokDgr5zDdfjyH/+hdPazxUVJd3LxdwZGk7wypa7Ly761lj8Ou
	 WLkgcoKd0vAVSH4cBXvC5vfgnC7TehIpibe3KzvHMS1Bp74dR/Rb6KG++DOOlSgw/GwCv
	 pt2oWheGix4O5tAcqXs4fxvRcVJdA3PgzK48jCAoGVPYWpcfye+M4jVBOPnzfFoAOmBEl
	 DZkwr7FzYDtCWE9N/6Wau9cgVt8hAeDOfwrHIK2KgAxRx4SCXgqOS2X8BAuKyRS6tmlPQ
	 tn5I7Y3b78blBuC8rtX97Fj3680sCQ6UU8qzUd0Y5eIk0srkQ91cf9OQzzmPxNtwRKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795476522;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=L9JyOQCk4ptyu6RbQxU+dboohfD5AUMkdLfi1iuTleU=;
	b=Elp5qQY+iAGN5bmAAFX75CFv0hPusMsodX3L5Rq3NHCZAgjCqBvlMogG14whqaW66pcS
	 X4VPlMCGLqZjxHAbiWB+eMOXqaM7IdKN8niw6K7jDQTFauc3T22HNY4VkBKr3/RfwNS03
	 lZj7Luio8ypieUVnZvmxGjCFJ746JFR0UpwN9sySCTXohJDHql3Ryn9494A8tj4JYKLEu
	 pi4G9+/1Rk4fdjEHw8PRrMF1HedJ/26HyBRWFbpzQLwvwQ9aDTs6PY6iw0y9RzAbOsvLw
	 suQNVZ9PvpWytDuZOA7S4lAVqVwOZAyOT/JJTwTAzXibNXXlkP+7zKuVPTEFp46EVvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=PQLI8hE2;
	arc=none smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE367606A31E
	for <linux-watchdog@vger.kernel.org>; Mon, 23 Nov 2026 23:28:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE367606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=PQLI8hE2
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c515319dd89so448561066b.1
        for <linux-watchdog@vger.kernel.org>; Mon, 23 Nov 2026 15:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795476520; x=1796081320; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L9JyOQCk4ptyu6RbQxU+dboohfD5AUMkdLfi1iuTleU=;
        b=PQLI8hE2R1ZGzUkL2UzSWWvZcZUNWbEK2ZsQoWVGFX7CEGc1Ppvh43+scgWTuGYSfQ
         Jy3+tanpEwx6suXJU0nO9wJ3a9zN0IDGAGXszyvRI+GioWxkWRN0cwnNPRAO1wYNhrl5
         xVY69xGf9dC1ApjEE2Y0IUxCzXOIefBy85krY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795476520; x=1796081320;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L9JyOQCk4ptyu6RbQxU+dboohfD5AUMkdLfi1iuTleU=;
        b=pIv0yFiJtH3D6FbyXGGE+Wiq/VCE/LXp4EgHFuacSTC9IQu4R/nCcWSgqS9ZYnmLfp
         V3Huz5gZoHeCjPBwj5+r48e4lHTiQN1g+1RRfTvl2oDLOEp4YGavee7IgT0rmJgubK/D
         cXc9S49Ka9EjIT9Q0nZtDCO8/+7odYdJGtWdrkD8vMK+1dqUj9bWkoPIA4PX+ZrM5IHi
         A5BBlMtrIR3/JIYdxfsOrlkFDE+4p51fmtLMiSq1eE20b/d7ZiSLclrQ1/SEhImsVc7S
         EKy6k80nPuIGDAzTn42T3m3D01KMiHl9roaKRbvPMyv59tSHuVsMK0goojzdgz77psxQ
         SzfA==
X-Forwarded-Encrypted: i=1; AL+hErGCaIYhJprP0OJqCqhLxBd+839jGiP7PEe5NFnFGJ0jiJO7yt2plaiP6cAYGDhempUok11i20Et4SMzT5IY+w==@vger.kernel.org
X-Gm-Message-State: APuU4Z//Py1XmbbisPOqNVtRvCUydKuos55KPxuzp6Dm3QV3sAwv+oJ4
	UjvFjVqr4Btk27EeX7PiP0TAa1PoCynMrPpBCRLh7h1A+Y+7+NcGEoEgEIM2/t1Bmif2QQX6JOC
	fmIcYkxL1
X-Gm-Gg: AZFdTZcPhbyd++iDWdRD4abZWp4lqfZbl9uBx3Ch11CgWEWXCTFTGNeGAdoeZlKZ4XJ
	p75QdfewUFvgrK0/RiVMcIE9ZzU5Vb42n3Y/3XLTwnT9VT2US5qvXpZGQjvsp5qUeptede+SLXo
	QypLWcNb89iOsUQgTntczJ1nOZemyYYvM1VylslIt+yTRHXJMeihvFfGTwGN5DyZ7fjLuAgWpFl
	pxtGqv3P5/B8md1y1DT+GLHShubc25GDmZ3P3EpwGg5F6tE6jy6hGDr4YgxUKzBTQiR/M5Ds3ju
	pBxEe6hQd8iTqMGiqYVIHF2LsPQOvmoQBO50eaUWRGjnLOPjSXJZuAYUEYAINqhY58/yzfYSxDl
	gDcptRQ5giPtvxEdJTHMopn1W6Q4dIEKW5h4baf3jIs4KlCWpDCscrLTbkscExLVU6zwjgrek8g
	//IJ5ijYm8jjjji6ENZyCljzlaeU/+Pb0D1iw4n0ARlv4/EP7T1SjPho9V42iO5TX1WXmGb2wJL
	edyxcKq2gxpSrLLitFWNgk5G+iAVwBLhxf1ql1TBLsKaK4UMK9EJfrxZ63+/ldrLI/eauf8loVu
	5+nMlOJAFCjP9Fe3dQl3fmU90AD64g9OymL8o78L+p3l3sqxNPGP14rMfykixU4HPRRVVQ==
X-Received: by 2002:a17:906:f8d2:b0:c50:bf14:8eb1 with SMTP id a640c23a62f3a-c513a84d84emr827538566b.14.1795476520221;
        Mon, 23 Nov 2026 15:28:40 -0800 (PST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513b030ed9sm458151466b.86.2026.11.23.15.28.39
        for <linux-watchdog@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 15:28:39 -0800 (PST)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4bb606491faso21609805e9.3
        for <linux-watchdog@vger.kernel.org>; Mon, 23 Nov 2026 15:28:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErH9cL9D+6kdIWP3PnTOtP49aAKO2Sb+V2tgILnS6aBJnS/b8cvsbf3DwphjyTWf0+fJZNryxZ69l47PFN2dNA==@vger.kernel.org
X-Received: by 2002:a05:600c:1c1c:b0:4a2:1364:252b with SMTP id
 5b1f17b1804b1-4bb8892ac4amr288126295e9.35.1795476518196; Mon, 23 Nov 2026
 15:28:38 -0800 (PST)
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112031629.396819-1-mrungta@google.com> <20261112031629.396819-3-mrungta@google.com>
In-Reply-To: <20261112031629.396819-3-mrungta@google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 23 Nov 2026 15:28:26 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WfqqTp8Bue35bfnHXiegqVbHxtDf0UPjg1JnXF_o_3ZQ@mail.gmail.com>
X-Gm-Features: Aa3M54rsKLWqkESys1duLI-KqFGibQ4RK6Ckuh_aN7G37_7JSHexELC5Pm6FEBc
Message-ID: <CAD=FV=WfqqTp8Bue35bfnHXiegqVbHxtDf0UPjg1JnXF_o_3ZQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] genirq: Allow global interrupts in request_nmi()
To: Mayank Rungta <mrungta@google.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, Marc Zyngier <maz@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, linux-watchdog@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	"Kirill A . Shutemov" <kas@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 11, 2026 at 7:16=E2=80=AFPM Mayank Rungta <mrungta@google.com> =
wrote:
>
> request_nmi() currently requires IRQF_PERCPU and forces
> IRQF_NOBALANCING. For global system-wide interrupts (such as watchdog
> pretimeout SPIs), forcing IRQF_PERCPU sets IRQD_PER_CPU and prevents CPU
> hotplug teardown (migrate_one_irq()) from migrating the interrupt off an
> offline CPU.
>
> Now that in-flight NMI handlers are synchronized via
> __synchronize_nmi(), drop the mandatory IRQF_PERCPU check and stop
> forcing IRQF_NOBALANCING in request_nmi() (existing per-CPU callers
> already pass both flags explicitly). Also check irq_is_nmi(desc) in
> irq_seq_show() (matching kstat_irqs_desc() from commit c09cb1293523
> ("genirq: Update irq stats from NMI handlers")) so /proc/interrupts
> emits per-CPU counts for non-IRQF_PERCPU NMIs.
>
> Signed-off-by: Mayank Rungta <mrungta@google.com>
> ---
>  kernel/irq/manage.c | 9 +++------
>  kernel/irq/proc.c   | 6 ++++--
>  2 files changed, 7 insertions(+), 8 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
