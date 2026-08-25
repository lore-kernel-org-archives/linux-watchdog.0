Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902BF1F427C
	for <linux-watchdog@vger.kernel.org>; Tue, 25 Aug 2026 00:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787616026; cv=pass; b=onmgXvOTmBiUUPKcgvvn4ZB1AxOwJmWrTLdFS7026gwoTdY5NC7lPwJ5Caf/hfnOzGpdGitNdeTgIZe57AiKXHmfXK0sfW8Ls7lZEr/0FB2MFfLju/TlN7bdoiwbD3wOSGEur0PS1PGxC/FE7JjuHvsGUGt8zXz6pWyOLLXwHXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787616026; c=relaxed/simple;
	bh=X/++xbGOvFtAQu2cxzysP+RHmG4xZ4+fn90ZP8dGcFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=me/Zc/oEFjh1HAmpUt4ic3PDbyBATDEX9g2fWGZbwCwjEX303tBVA9TiYwV9yZbLUu2Q89r+tJ36maXn1+iPwXmIMHoIYeU0bHtXE7cuHyNKsEfUTD5+C+A2MV+LKBo3KgMACuY6X9uAlZAo7x3I2vZfWZKteF6Fo/zoxnyofUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DzFFWujc; arc=pass smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DzFFWujc"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7e6b5737bb2so5985347a34.1
        for <linux-watchdog@vger.kernel.org>; Mon, 24 Aug 2026 17:00:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787616023; cv=none;
        d=google.com; s=arc-20260327;
        b=eKt2XUCLGukMqOqVZuUbC0vFFRPX21zEEdQK3Y8Jez6BF1mHWZ5CN9BQy7cz0/4J3h
         TN+Ye3BRzraPy3xzqHkBsyD1uYQnn5ZCaKW/4OiqCriHbtYz60hU8VY7CLD2rQnI5Nc3
         kBMxC77PSdWJcNPGaQG/K70RocsxZ4/YA9YU2WgIArk9AnW0W/Dhplwpkisr8rH8EwJA
         W062Ir7+1xmYVLU3MlLIQOK9QKRLyPRLoV2kpoaNhL97znSVcxXQ5j+2XOAg3VvY6LjT
         rZz0d9mR+PmIgBzbPsXy8ndliearfRYgZG63JxuP68EAtiLtOayg2vKWLbvEmTZAEcdJ
         eP8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=X/++xbGOvFtAQu2cxzysP+RHmG4xZ4+fn90ZP8dGcFU=;
        fh=iJoh8/VVVDFC45IEktnS3qYBfcg8L5RGHTIZVQVY0ac=;
        b=TLrtK8r2fiVdtCcU3WiejkcVPRTnDDkPm6Pl9BgZAXQfcPWVh3pRvPbZoOOal+KZ3C
         hMuECPQNSn2KaWk7XgzrsAGrIvua2Qnlik4FBeUOGmKRC/UQs3hlm3pUkBlJRLbPa2lN
         sygUNm2SELsYy//38AHQJ9t1UL0NjrTlCR6wbErmcUEWB6/kEn7RUTK84MfWob1U3dHV
         QMX0I9nymvRxYUO3JOviIaABHxjOxKubt8mzrgN7w2TrmclTT33Sr28wQihlm1hv3qh8
         PtV24h1rmA926JnJoVpW5jvfpRasuhInsCC/DYzsARDzqz1rHxd8O2gUfzRAR5xcYEyq
         v2GQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787616023; x=1788220823; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=X/++xbGOvFtAQu2cxzysP+RHmG4xZ4+fn90ZP8dGcFU=;
        b=DzFFWujc3Mo0f6kDgbLnzoVMJHN0UMZ0XjVJlWq/aFHU8xM8qWyUOe/iguId7dIK32
         Pcm2txEaTnFKK4MbeYVpkrlP8WvtDBIU/eFcuxL2xcq+ViBEQph8o7XoEeS1VVxrCg/q
         hYjEZFkMXgiSgGgi630hUQYFABJIHWHLMGLu/e8gbZIT0bdaAmI3TSAQKWk28UyfSAks
         6f9zlbAkekULEkEIOje9OSjvacw0wyaTaqIdAf0fVC/4Y1Ei3EEb31mtczpA9fm2Jr+w
         LVxydUzD1KEBbC2atGVL23h2Ur/xz66ZugOrTqMGD7yfPwgqw/6Btzsng4aL7WALbTPh
         eZZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787616023; x=1788220823;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X/++xbGOvFtAQu2cxzysP+RHmG4xZ4+fn90ZP8dGcFU=;
        b=C4dIrX15TwACFr/AdJc2ZqrURthd9vR58i1UYgtSapbsF55MRgq6T6dhhXoiMmZ6ih
         R0iohKoPBvMWQpTJg6iFpamaMxIQwRdPvlTI8LHaBCluVSnEpfED4iyLB9sCyMOT+o6h
         AfXI3CEzlckEAmR8UDGoIgYJMtNm3ImcMyPfAB30e0B8YUiUgi6Zw3ibGXWMoBpopBBs
         VV/9Lc+G/yZj9VfvmHXhvcs4rdcPV+SCPjxOXRupyZuMNZioR0DAjQ8N59zaIT0+JbVs
         d5AC4ju69fdmX4b5bKewf7e/Vutn/ygpabP1xb5tU2DP7L+pEHeTbYSatvJG+nsB0RYU
         h+mw==
X-Forwarded-Encrypted: i=1; AHgh+RouEmkVRbppj/naRy9lRNfHfQgUBRoDyQKpA6YnlJkLPxu/9XWCwchQ4xwNZiNRMpdZFZ0uuTLBwG3BIqNhEQ==@vger.kernel.org
X-Gm-Message-State: AFuF++nM77I9P5zzCU3wJu0q5xvnDK5NOQW6Jq11XrwiChOov4xasQbi
	Sky9Yf28JEay2KRnpyJQoRp1IMj4h0G9nRDk+/7GqIa5gayze1n8ONcvrLlRl1kn32f4I2HyX5q
	P0YKYmbrl6r37ZCAg09LO0xVRYfnRlE7LlRVW1lSI
X-Gm-Gg: AR+sD10QAWqZskcn+2MhDSnGl+ybU1NVxa4S/YbR8RGoBQJuuVmssq8+qU+dRUca9Gd
	S+tOzyu8LgUf3m56voSaragZo39nNNx1rfb14NCkTyrb4sMs81pqAEwnwLjlbHQiUeLkqMwBbmR
	v1C8Gz7b4ShfzuzKpPpOO4qsjXkbzutIMEeJ39MYd7W1xBxNYtMlTglqqLQRNzXXCRJ4H81Bf7Q
	uXR2WdyhKO0eFv9d4Bqgk8aUfHMcYjUCrimZ9Z5LIqqM9BDM/VcWp+gMcLVWuZwgaE3cbSpq2ZJ
	FsvRHurLDuN8E4oSdbR/1RHiJj7WkKnfGvF2umFyQAkmz2aD1AaZvBPgrAEg0AK3bEjoWumgXTl
	0Tg==
X-Received: by 2002:a05:6830:83a5:b0:7e9:c72e:e5d6 with SMTP id
 46e09a7af769-7f4619f7498mr33999953a34.14.1787616022882; Mon, 24 Aug 2026
 17:00:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730-qcom-wdt-nmi-series-v1-0-3aa86d162914@google.com>
 <20260730-qcom-wdt-nmi-series-v1-2-3aa86d162914@google.com>
 <CAD=FV=V+nrmtK6FJ2G+LGnvxkLEWMR+2A253-gQ2smxf9LoEWg@mail.gmail.com>
 <eddc90dc-3223-4356-9e9b-350af904b144@roeck-us.net> <CAD=FV=XuCHdOv8kct63JzmbgjxJMxL7fc75KtAQL0hbJc7_v0w@mail.gmail.com>
 <87h5l5ex9r.ffs@fw13>
In-Reply-To: <87h5l5ex9r.ffs@fw13>
From: Mayank Rungta <mrungta@google.com>
Date: Mon, 24 Aug 2026 17:00:11 -0700
X-Gm-Features: AcwNN1U5QkUUpN8cD3tqaTu98qlmKgL7-oQjdvPiyLexse4QcoQ423aVgpBBw18
Message-ID: <CABz7rdCKHcXx6U5qo83HaiR_b17CsoQoVVEiZ=03c+h2FUFHpA@mail.gmail.com>
Subject: Re: [PATCH 2/3] genirq: Export NMI APIs
To: Thomas Gleixner <tglx@kernel.org>
Cc: Doug Anderson <dianders@chromium.org>, Guenter Roeck <linux@roeck-us.net>, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, linux-watchdog@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	"Kirill A. Shutemov" <kas@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 9:00=E2=80=AFAM Thomas Gleixner <tglx@kernel.org> wr=
ote:
>
> On Fri, Jul 31 2026 at 16:18, Doug Anderson wrote:
> > On Thu, Jul 30, 2026 at 3:55=E2=80=AFPM Guenter Roeck <linux@roeck-us.n=
et> wrote:
> >> > This seems reasonable to me. One thought I had was that we could
> >> > possibly get by with fewer exported symbols by changing
> >> > disable_nmi_nosync() and enable_nmi() to "static inline" functions i=
n
> >> > the header file. That being said, what Mayank has here feels slightl=
y
> >> > better to me.
> >> >
> >>
> >> I don't claim to understand the NMI APIs used, but Sashiko's feedback
> >> seems real to me. Someone who knows that code will need to confirm tha=
t
> >> there are no unexpected pitfalls.
> >
> > Since Sashiko doesn't reply-to all, here's a link to its feedback:
> >
> > https://lore.kernel.org/all/20260730214758.DBD5E1F000E9@smtp.kernel.org=
/
> >
> > Indeed, it does look like legitimate feedback. While the problems are
> > pre-existing, it is true that exporting as a module could widen the
> > exposure because the code backing the NMI handler could now be
> > unloaded.
> >
> > I did a little bit of AI analysis of the problem myself. As far as I
> > can tell, it would be relatively safe to implement a synchronous
> > "disable_nmi" by just calling "disable_irq", much like is done for
> > other NMI functions. The caveat here is that it would only be safe on
> > IRQ controllers that provided irq_get_irqchip_state(). This is because
> > on NMI we don't set IRQD_IRQ_INPROGRESS and thus
> > __synchronize_hardirq() will fall back to calling
> > __irq_get_irqchip_state(). If any controllers supported NMI but
> > _didn't_ support irq_get_irqchip_state(), we'd silently skip waiting
> > for NMI completion. Maybe we could simply make it illegal for a
> > controller to support NMI without irq_get_irqchip_state()?
> >
> > I guess maybe we need Thomas Gleixner to weigh in on this? Thomas:
> > should this issue block Mayank's patch? Would you expect him to
> > propose fixes as part of his series, or is this something you'd prefer
> > to post patches for yourself?
>
> Sorry, I did not pay attention as I was AFK and busy with bugs. I'll
> have a look once the dust settles on my side (hopefully soonish).
>

Hi Thomas,

Friendly ping on this thread!

I completely understand maintainer schedules are very busy. If you
haven't had a chance to look at this by the end of the week, I'm happy
to take a stab at implementing the NMI teardown synchronization in v2
myself for your review.

Please let me know if you have any thoughts or guidance on the approach.

Thanks,
Mayank
