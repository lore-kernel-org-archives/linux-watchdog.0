Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951702D12ED;
	Fri,  7 Aug 2026 16:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786118421; cv=none; b=NE9bdIohTtGu+Ujj2hMkBjeSe9eDKyKLiFLAMOzznzasgLMYL8iEzR4co5cprKs3vbAFZOnZakIbeWYTovBmBt5ELCLCmj5dF9kmW3q1yMgi/EpONY7ZUpCC+HgsT2B00HHiZA+V7PmLj2M4BaWF7DU7RpqHRP5zeiXPNe0hI+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786118421; c=relaxed/simple;
	bh=d3xAd7lC+SHHkZEW0Dme9DEiQrv1UbMVfR04aVU/hws=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U1qEB7qomRDAoKaqXiW01GAgvkGH8zLb/MOcFJqBb8GgRFyTIpuBzciDm1HA0aUkMUAdqFkTD1O1YUJ2do+jZQdpJkWGiV0w45ThkYCOrvZ+DHuZ5VPvbyhs6YugnbrOHQV8cBd1XUcUfjDBD1QFbtbL5hWu/80ibtOUzjHQLTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XCeCBu6L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XCeCBu6L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 707C31F000E9;
	Fri,  7 Aug 2026 16:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786118420;
	bh=hRv0UHtWHb9R9fCBskzcQRc4pcX1YBZCkcZ4QjTrOBU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=XCeCBu6L2gjcvPUYkrMQuPv8Q6SfOQw1kg722KQBUJcPlvBeWkDkWd6wlOWFswAMo
	 QoZhdZ9sqv/e+Ikcl1C6PGZ3weTFUAQsSZcNxysykiwuLK4NtSmCEj7XveZDNhLUX/
	 xC5W5t2nQKeoNvsg460xhyobNO5HrRDEzy9MlUfHOgn5BTKhO56PoiX/EUt+X7jYOA
	 OVijKbgHxWD1/QoB9o2RIwmAL0sWL1bEOtJGW8Mig35eMe31bhhajUTNc5JxMZIrHs
	 RqcFDEkuyJNyWkxvi4CFXkxpNogESqIeIe+YwXE04hEQ5IK2k2TagloSGHiystkoH3
	 IDSVerp56eoNA==
From: Thomas Gleixner <tglx@kernel.org>
To: Doug Anderson <dianders@chromium.org>, Guenter Roeck <linux@roeck-us.net>
Cc: mrungta@google.com, Wim Van Sebroeck <wim@linux-watchdog.org>,
 linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, "Kirill A. Shutemov" <kas@kernel.org>
Subject: Re: [PATCH 2/3] genirq: Export NMI APIs
In-Reply-To: <CAD=FV=XuCHdOv8kct63JzmbgjxJMxL7fc75KtAQL0hbJc7_v0w@mail.gmail.com>
References: <20260730-qcom-wdt-nmi-series-v1-0-3aa86d162914@google.com>
 <20260730-qcom-wdt-nmi-series-v1-2-3aa86d162914@google.com>
 <CAD=FV=V+nrmtK6FJ2G+LGnvxkLEWMR+2A253-gQ2smxf9LoEWg@mail.gmail.com>
 <eddc90dc-3223-4356-9e9b-350af904b144@roeck-us.net>
 <CAD=FV=XuCHdOv8kct63JzmbgjxJMxL7fc75KtAQL0hbJc7_v0w@mail.gmail.com>
Date: Fri, 07 Aug 2026 18:00:16 +0200
Message-ID: <87h5l5ex9r.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31 2026 at 16:18, Doug Anderson wrote:
> On Thu, Jul 30, 2026 at 3:55=E2=80=AFPM Guenter Roeck <linux@roeck-us.net=
> wrote:
>> > This seems reasonable to me. One thought I had was that we could
>> > possibly get by with fewer exported symbols by changing
>> > disable_nmi_nosync() and enable_nmi() to "static inline" functions in
>> > the header file. That being said, what Mayank has here feels slightly
>> > better to me.
>> >
>>
>> I don't claim to understand the NMI APIs used, but Sashiko's feedback
>> seems real to me. Someone who knows that code will need to confirm that
>> there are no unexpected pitfalls.
>
> Since Sashiko doesn't reply-to all, here's a link to its feedback:
>
> https://lore.kernel.org/all/20260730214758.DBD5E1F000E9@smtp.kernel.org/
>
> Indeed, it does look like legitimate feedback. While the problems are
> pre-existing, it is true that exporting as a module could widen the
> exposure because the code backing the NMI handler could now be
> unloaded.
>
> I did a little bit of AI analysis of the problem myself. As far as I
> can tell, it would be relatively safe to implement a synchronous
> "disable_nmi" by just calling "disable_irq", much like is done for
> other NMI functions. The caveat here is that it would only be safe on
> IRQ controllers that provided irq_get_irqchip_state(). This is because
> on NMI we don't set IRQD_IRQ_INPROGRESS and thus
> __synchronize_hardirq() will fall back to calling
> __irq_get_irqchip_state(). If any controllers supported NMI but
> _didn't_ support irq_get_irqchip_state(), we'd silently skip waiting
> for NMI completion. Maybe we could simply make it illegal for a
> controller to support NMI without irq_get_irqchip_state()?
>
> I guess maybe we need Thomas Gleixner to weigh in on this? Thomas:
> should this issue block Mayank's patch? Would you expect him to
> propose fixes as part of his series, or is this something you'd prefer
> to post patches for yourself?

Sorry, I did not pay attention as I was AFK and busy with bugs. I'll
have a look once the dust settles on my side (hopefully soonish).

Thanks,

        tglx
