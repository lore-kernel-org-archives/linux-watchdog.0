Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC3D34FF41
	for <linux-watchdog@vger.kernel.org>; Thu, 30 Jul 2026 21:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785448394; cv=none; b=BvQkqh45yCP09k9OE5/uxZq0MJ8vppz8P4jZwChGZAoA8MI8ndVzzzWhFeObSbNllyDv6eds6hDMEszFs3i+A9Zn0i3iysk8P8DTyzaoyw507Y85kpcLNH+bKdr9BucZewcQ44JSp1H+8dnKXo1NhOj8BkdVjPPrGqC/UmknWac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785448394; c=relaxed/simple;
	bh=n7xZ4d6pDBOIsBccoj41PoA0ulZULmTJlTbJyd3d0b0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wn1vu4xNwPyNtVQ7lF/hJrQTmlil84bZfqt/DF3RDr2B65C1wFXw0lzoBxwRchUV94bsUw6904htTyjtsuTJ7acaAfSMXmIsH4V3FwloC8gjLMHM8QWrXa8pf54xXtEKxVJ3jIG8S7tmsxfaeVO0yzs8FLFRNupd5nQubjS2d+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=B8Kr+oFz; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B8Kr+oFz"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-9770e900464so143668241.0
        for <linux-watchdog@vger.kernel.org>; Thu, 30 Jul 2026 14:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785448391; x=1786053191; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=N6weBl8nXyjz9nQrg6nLHwQNYvi+4xIJ6U2EjMla1oo=;
        b=B8Kr+oFzTf4Ibm5uhj8g8nnzpmlcQH3x1pnXGGTgsKcUq2bUrvNU6nhj3EIb2Pgk4M
         P+zfkSWczarWbGg7lXFyL2I5ZdGaJ0D4RlbNyk5yHYr6exXLhb9URKcb/jpUnpVPUn4J
         hIFhwSUoe0t8yl2pCh961dO00HshXSZIiAS6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785448391; x=1786053191;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N6weBl8nXyjz9nQrg6nLHwQNYvi+4xIJ6U2EjMla1oo=;
        b=obP0ZOcU+Q23IY8OATGtwQQ9sTcPO2/oboFMJ7LByImtlM0uB85kmtbnJAYIUR0+Jo
         +8f153mciqosXmP//vszhbrZlha1z7S7k+ZFSr0JSUymZXD+mmEFQazeCP/6GQ2kKol1
         R+Nzy9KlpMxO0GYxY0og0OwWww9a+SidkI1WwtZR5oOEn9Uv9LhMg655flSjVj+RvKyi
         FHO3si7ccJVkW2IlgNNXpFrMUu7gY9l98YkEK9zG1UfnkYxJWs+7OllbuyCafDmttvMy
         gHXB49ZBdhP9QNrBy13fq3YT1OfNig8ZtGzCA0q+8MQ5JmMF+1Xks2u5WTyxoSypF+f/
         wNFA==
X-Forwarded-Encrypted: i=1; AHgh+Rpg2ORaS0baTaP1j9397w/3Aeg4YBJadLUHzC72ptzHJcUIOgfcQmzbrZA6NAY3QOEHQpnb50y/ywrHlu1JVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyuYRoEkkHxgGWsIA8g9gkzSJf0/wcliPTnJq+FP+iRKuJ2Li8G
	6FMu3tR9pv+05+p/Dls07vkMA2w9UNS1uUegrUtgg1PxUpKFR5PHgyKl6v72N4JIzpP4u/K1fTv
	PdZM=
X-Gm-Gg: AR+sD12UkiOimVS44n8qRHl/aNbdVm3BexSGIsBo9YOrtILjjfziJzFeBmdbzeClzzh
	uavygxFZ6hr4zFWWyDnbH2s/HRjB7ZglG5knE7ZdKKiyUZ3hNHTqJXH4qrBFoMeoptXK/lmVExf
	8FfEf7C8aTxv8KmqeG5zHJSlDJPWwZrpNmHGyix1uTwdUWkT2Sj+QdhQByt0IMJGyVpbeLQ5qSu
	tc8pNJQLzdQ/N/elSiTWP5QW4HytbHYJKN7XAfy+3cPAuMhFvvRgnFeu4iEx1bn++olXvNsBgbu
	e2BYpL0KBXReEPuebHhyW0qtF7+JU+hZKn8CWzRQnK2EFZwhh2eQggMOsRCuMpA8uV1lwa6199Z
	eZ4+mk4oV67RuVS8l0Jr4SgXFKZGL6jwDwtra+/vqoMfjZWQOKxol+f9K9dlzy5muBviqurv8kG
	x4Kjc3OrUHgkZywoKrrLaJcz5mo2NScZfMAebrRlmTKLKG635+uzZ5k3RSgyQwZmZjWHfJ0RaFe
	oTogVCeWNhMMcUq6UHm665tv54=
X-Received: by 2002:a05:6122:1903:b0:5bd:8dd8:146e with SMTP id 71dfb90a1353d-5c373e2d932mr760580e0c.4.1785448391422;
        Thu, 30 Jul 2026 14:53:11 -0700 (PDT)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c3666d53a3sm2643781e0c.12.2026.07.30.14.53.10
        for <linux-watchdog@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 14:53:10 -0700 (PDT)
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-977ba4d3b49so141699241.1
        for <linux-watchdog@vger.kernel.org>; Thu, 30 Jul 2026 14:53:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpyiPFl8FPqa/we5bEWEq/dTMpuFZqGU0s60RufwzKTjUyymzP5mR4gFyzbYEYkAKHJ0kvq13B5DN05JhnCpA==@vger.kernel.org
X-Received: by 2002:a05:6102:14d2:b0:744:ef7e:8f85 with SMTP id
 ada2fe7eead31-7582acd5ff1mr590809137.15.1785448389325; Thu, 30 Jul 2026
 14:53:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730-qcom-wdt-nmi-series-v1-0-3aa86d162914@google.com> <20260730-qcom-wdt-nmi-series-v1-3-3aa86d162914@google.com>
In-Reply-To: <20260730-qcom-wdt-nmi-series-v1-3-3aa86d162914@google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 30 Jul 2026 14:52:58 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XiTw7ueV5BeURhG50LXUR0ZtPpJWTF-AuQEaySrVTigA@mail.gmail.com>
X-Gm-Features: AUfX_mx22NpO5lnS3W8reOG7Q_qsbtJ8_4eaA_IlpPB6diF6oZxCuem5LyMUp48
Message-ID: <CAD=FV=XiTw7ueV5BeURhG50LXUR0ZtPpJWTF-AuQEaySrVTigA@mail.gmail.com>
Subject: Re: [PATCH 3/3] watchdog: qcom: Register pretimeout interrupt as NMI
To: mrungta@google.com
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Thomas Gleixner <tglx@kernel.org>, linux-watchdog@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	"Kirill A. Shutemov" <kas@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jul 30, 2026 at 2:33=E2=80=AFPM Mayank Rungta via B4 Relay
<devnull+mrungta.google.com@kernel.org> wrote:
>
> From: Mayank Rungta <mrungta@google.com>
>
> When a system is completely unresponsive due to an interrupt storm or
> deadlocked CPU cores with standard interrupts disabled, a standard watchd=
og
> pretimeout bark interrupt will fail to execute, preventing the pretimeout
> governor from capturing CPU backtraces before the hardware reset bite.
>
> Attempt to register the pretimeout interrupt as an NMI (or pseudo-NMI)
> using request_nmi(). If NMI registration fails due to lack of platform
> GIC pseudo-NMI support, fall back to devm_request_irq().
>
> Explicitly arm and disarm the NMI during watchdog start and stop operatio=
ns
> using enable_nmi() and disable_nmi_nosync().
>
> NMI Execution Call Trace (lkdtm HARDLOCKUP freeze break):
>  Kernel panic - not syncing: watchdog pretimeout event
>  CPU: 0 UID: 0 PID: 5419 Comm: bash Not tainted 6.19.0-rc5-00022
>  Hardware name: Google CoachZ (rev3+) (DT)
>  Call trace:
>   show_stack+0x24/0x34 (C)
>   dump_stack_lvl+0x84/0xac
>   dump_stack+0x1c/0x34
>   vpanic+0xfc/0x2d0
>   panic+0x6c/0x74
>   watchdog_notify_pretimeout+0x34/0x48
>   qcom_wdt_isr+0x20/0x34
>   handle_fasteoi_nmi+0x50/0x88
>   handle_irq_desc+0x4c/0x68
>   generic_handle_domain_nmi+0x38/0x48
>   __gic_handle_nmi.isra.0+0x40/0x90
>   gic_handle_irq+0x64/0x234
>   call_on_irq_stack+0x48/0x88
>   do_interrupt_handler+0x74/0xc4
>   el1_interrupt+0x5c/0xb0
>   lkdtm_HARDLOCKUP+0x18/0x28 (P)
>
> Signed-off-by: Mayank Rungta <mrungta@google.com>
> ---
>  drivers/watchdog/qcom-wdt.c | 55 +++++++++++++++++++++++++++++++++++++++=
++----
>  1 file changed, 51 insertions(+), 4 deletions(-)

I pre-reviewed this for Mayank and it looks reasonable to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
