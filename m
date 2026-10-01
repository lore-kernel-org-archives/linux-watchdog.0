Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B33310645;
	Thu,  1 Oct 2026 18:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790880628; cv=none; b=O82gJ5ed5zsU81aFEVaN+LnFSvOaO6oV9j2E7IATWl64bpbvjruR7zYCfQWsLE1EruyACf55KP6gL4egKvhBQotpMYstg3A48Mpy8LHbZz03fwNgHel9tHV8y4no+y3wvpe9OX21DtMi4f058BxDtbATQVZobGy/Af6Yf693KFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790880628; c=relaxed/simple;
	bh=mZRjcadC4nR/ZatJwWUNXv5Fgr5vMB+vEWcJxnB7Dys=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pFGNxiEfG4AEZIKCDEaa/URpv+KcituXGFazUhhtsUGoMebL32774u+OMv2ha/k8zjjA7ay7i+Dhz5jgp7EOQEQf/eUXEWp9/SH4HuoOMxpdikuZ26DvBYAclbME94ii6pJ+f4N8R4pFn+FExqnV3hWy96aljnLiuCGidtRVnwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GlmJaiYd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GlmJaiYd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C2421F000FF;
	Thu,  1 Oct 2026 18:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790880626;
	bh=FsBIYxY4xAm8A715N3pPJbTF5MXYNmvykMIWcfCsZx8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=GlmJaiYdePeqnwwBhQorPA+xGslNQLuKkRzCXs4oGFVAVmscYjMj00p53OMTQ1tl0
	 KHaXL5R3vaLZ4PqfvWgHLY9SxDCZZOSkwD/jyZ6zI8VHX4Bly56pUKGlNKS2L5OY9x
	 LS/DMHIvERfXL0ZUKDBltZ2XuQ3G8zm95bCR9Kc2RCBPSKn/Kri4CIEK2eUZQkUUeX
	 YIP5GjvcgAwlUOYHpXHvpM5z5TnnMUMQzDfLbPQZdy4Gn0GlYts2PHSveyAhXZKHaX
	 xD5p/1RWz78SCuLlhCL125YXuhuikjn7TcekB6LsLLl/LHOSXOAzXxkkjjukDKaLIq
	 r71ADviR5l19g==
From: Thomas Gleixner <tglx@kernel.org>
To: Doug Anderson <dianders@chromium.org>
Cc: Marc Zyngier <maz@kernel.org>, Mayank Rungta <mrungta@google.com>, Wim
 Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>,
 Radu Rendec <radu@rendec.net>, linux-watchdog@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, "Kirill A.
 Shutemov" <kas@kernel.org>
Subject: Re: [PATCH v3 1/5] genirq: Synchronize in-flight handlers during
 NMI teardown
In-Reply-To: <CAD=FV=VuSEzHw8JJsTXuGEEe-w_T=_w6ycsqpzpNWDHxMqyJdQ@mail.gmail.com>
References: <20260902-qcom-wdt-nmi-series-v3-0-f3999362a9ea@google.com>
 <20260902-qcom-wdt-nmi-series-v3-1-f3999362a9ea@google.com>
 <87fqzp8jex.ffs@fw13> <87wlt13zj1.wl-maz@kernel.org> <87v78l6oha.ffs@fw13>
 <CAD=FV=Wdqn7UiuRy1VY-qH+JYChLTEQgmj2q6Q=FBjCZ+5eo1A@mail.gmail.com>
 <CAD=FV=WE-Wn60zTn=nsq4qLis_zjncrS37fND6ehtpuvxYp+DA@mail.gmail.com>
 <87o6deh0pm.ffs@fw13>
 <CAD=FV=VuSEzHw8JJsTXuGEEe-w_T=_w6ycsqpzpNWDHxMqyJdQ@mail.gmail.com>
Date: Thu, 01 Oct 2026 20:50:22 +0200
Message-ID: <874if5gsr5.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Sep 30 2026 at 16:17, Doug Anderson wrote:
> I guess I'm still unclear on one key question: if we post up clean
> patches that allow promoting global interrupts to NMI (or pseudo-NMI)
> level, would you be willing to review and eventually land? I got a bit
> of a vibe that you just didn't like the idea in general, but maybe I
> misunderstood. I just want to make sure Mayank doesn't spend a bunch
> of time trying to solve this problem if it has zero chance of actually
> landing.

I'm pretty reluctant to export a general "promote me to NMI" interface
to drivers because that's just a recipe for disaster. Watching driver
writers creativity for several decades tought me some lessons.

Though I understand and agree that in particular cases like a watchdog
this is useful and should not require to have the watchdog built in.

One clean solution to that is to provide a function which is exported
via EXPORT_SYMBOL_FOR_MODULES(). Then driver writers who want to use it
must add their module to the export list, which provides at least some
means to catch abuse early.

Thanks,

        tglx
