Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD2D30ACF1;
	Wed, 30 Sep 2026 21:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790804784; cv=none; b=Ssg7DO1tmnk3V7RL2/v05bg8LckHBV/cy5XRq3x2FwZQyUVDhjNdvSB5WY/442biDRCKB51QSlZ/Nt5chKKaBypbGgNZYNu7s2cXnv080s8U/bHdehcxxD+F5caWw+7QxWzYHJ3/0U6vA1JCjM7WkUzGDVIR6/h43GQlYLpM5EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790804784; c=relaxed/simple;
	bh=3iuEjO2MpK0D95af1nsWvN600i/DZSAMF6zrFFAr3/E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=racB1tnhwG7oQw58z87i7hfRoTZbqH6IpyOmGZk89JGxo2pulqbTEjtjKvcf7ZAVG81U8k8U7E7hQZ5FeD+S66MDbi5yXJz46BsQ4p2LxrEWuGaaZeS6VT7Q7WD0XfOJBTKhLZoRYueOsQaX3h1aPhH9kmFX+dMB/jkidLHZbCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ooFvwKMj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ooFvwKMj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5FEE1F000FF;
	Wed, 30 Sep 2026 21:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790804782;
	bh=ldMOrQjh0P5/jcFu0TzEsRwLwVAqyKDcS37asFhMWNY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=ooFvwKMjCPrhFufbh/VTKIh1OGcN4OomhCW9dRuQTQBObPjNCTFjyX3hWncitgwYO
	 +8yhpdZcACJNvEadcSpOrtOSNIxPZ0V5jFuu65mTRIVaBoyZ88qs0+wX4w6v1IfGkj
	 qkGq/hjXHMLwMr+3kmxm/vrc+ch42wltCRJH3Q+WLMxo4UCo5wV9QUdb0gXthcDWnv
	 hWWAgi8Y102z0tSiuFVQDBkFIREMzlpshwLuZoYlTMqbsfuRXmgKfs0apPxpvMOVBD
	 Hwaw81h2p5RBikr+KxbxJ8B8xxzuIpRSBbTqfphOjp6Cj50f9QXBZ3sTSe7dmaX6xn
	 P9GfZcBm7PL+w==
From: Thomas Gleixner <tglx@kernel.org>
To: Doug Anderson <dianders@chromium.org>
Cc: Marc Zyngier <maz@kernel.org>, Mayank Rungta <mrungta@google.com>, Wim
 Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>,
 Radu Rendec <radu@rendec.net>, linux-watchdog@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, "Kirill A.
 Shutemov" <kas@kernel.org>
Subject: Re: [PATCH v3 1/5] genirq: Synchronize in-flight handlers during
 NMI teardown
In-Reply-To: <CAD=FV=WE-Wn60zTn=nsq4qLis_zjncrS37fND6ehtpuvxYp+DA@mail.gmail.com>
References: <20260902-qcom-wdt-nmi-series-v3-0-f3999362a9ea@google.com>
 <20260902-qcom-wdt-nmi-series-v3-1-f3999362a9ea@google.com>
 <87fqzp8jex.ffs@fw13> <87wlt13zj1.wl-maz@kernel.org> <87v78l6oha.ffs@fw13>
 <CAD=FV=Wdqn7UiuRy1VY-qH+JYChLTEQgmj2q6Q=FBjCZ+5eo1A@mail.gmail.com>
 <CAD=FV=WE-Wn60zTn=nsq4qLis_zjncrS37fND6ehtpuvxYp+DA@mail.gmail.com>
Date: Wed, 30 Sep 2026 23:46:13 +0200
Message-ID: <87o6deh0pm.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28 2026 at 09:14, Doug Anderson wrote:
> On Fri, Sep 4, 2026 at 8:26=E2=80=AFAM Doug Anderson <dianders@chromium.o=
rg> wrote:
>> On Fri, Sep 4, 2026 at 8:11=E2=80=AFAM Thomas Gleixner <tglx@kernel.org>=
 wrote:
>> > Of course this is a regular global interrupt otherwise it couldn't be
>> > requested normally. So this sets IRQF_PERCPU (it has to otherwise
>> > request_nmi() would fail), but that looks like a hack to me.
>>
>> At least on GIC, promoting a regular global interrupt to NMI (or
>> pseudo-NMI) level is possible, and Mayank's use case here seems
>> legitimate. Any suggestions you have for making this look less like a
>> hack are appreciated! :-)
>
> Throwing an extra plea out here to see if we can make forward
> progress. IMO being able to make watchdog driver "bark" interrupts run
> at NMI (or pseudo-NMI) level is an important thing to do for
> debuggability of the kernel. It sounds as if there are no general
> objections to the idea. I guess the next step is to make this look
> less hacky. Is that something we could send patches for? Any hints for
> what you'd like this to look like would be greatly appreciated.

I think the objections have been layed out in course of the discussion, no?

> I'll also be in Prague next week for both Plumbers and ELCE, so I'd be
> happy to discuss this in person if that helps.

I'm going to be there, but I don't know about Marc.

Thanks,

        tglx
