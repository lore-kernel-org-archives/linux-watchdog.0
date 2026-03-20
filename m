Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2713C1961
	for <linux-watchdog@vger.kernel.org>; Fri, 20 Mar 2026 14:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774016480; cv=none; b=FgucMonoS1/YQEbvuUiIQk4CYGcUSWrRZFIY1hKgeClR4pK8VKPihMsPi8CcskwS4RyvMKLa/hLVVB2+RQjmBfJ/YzN3Y6T3evyexZY9NAgH40+Ov3eg6RgLeVQSuDQF/uuZZ//t6QkqQiyJzfj/aO078tcesHNxV2PtZi9oLAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774016480; c=relaxed/simple;
	bh=SqM2AKs946P+FYY/eyn1mHQZcwnT+QeDlAmSMReOErk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UGFDeUn5vxdYEJs25kZcPHGujA+RkHGh4xmGC2BPGJ/7NMZ3rq6AAWob6Z1tvC4WfParbJd9rcLuKceVytf8WNfPSQOZZSwvp5SCW+V0Y5iRvAE58didI0DrMcLG4q1Nw73pxdJfosqsvSZgETW1XIClZmfTUzM8jpnE3941AME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i1zICym7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i1zICym7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD8E6C2BCB6
	for <linux-watchdog@vger.kernel.org>; Fri, 20 Mar 2026 14:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774016480;
	bh=SqM2AKs946P+FYY/eyn1mHQZcwnT+QeDlAmSMReOErk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=i1zICym7fUQjh+a/G2tiFppLoSbOQLYgTbPUF5kogGE7AA1epD7RkClPWEqRbzBRg
	 8COtuH5YKkcPMU6n/1IgKu7cp2SqSl9qPaLewylDLLcsm584AzbZ6yRxOM4RUIZpjG
	 nd1UALaqhQGCmMFEnCf0gJomdfXJ4gK5cxqLSheZFwO0lffebHn0BPXmYOyRbThojT
	 Iacqx5tJf6us+2248JJq8sTX2hCVKJTQ/LMdWlYmz5mcHtJEegVIj7S1A93rq3ILNs
	 ge4f7dLpaDWIAZJwdTrlwNWq6wo+MpSTV0YmoD265To4fRYML2u/QAau/CxrlaMeco
	 zsuzf+vk8xvtQ==
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-79801df3e42so28123937b3.0
        for <linux-watchdog@vger.kernel.org>; Fri, 20 Mar 2026 07:21:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVqifxcdjeVE6hsS+yvKD1cEUR9jDbusTklJtJfGBI0cDBPCpItADac4aXaJsWte8FG+57BJwZfsarmQeVIRQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5s6sVZ369pD0rE7nt6puXdMWuLF9tj8oxWc3DWt2Ziz6sLBiP
	JD3ymMHhMniNEn66xT91LfjntwUB4n6mxhv35tqcFOAHl1MqDlSx15xRLgIpFdLaUl7cgGVG/k5
	8kSxRJf786gRLLIb7XAn+wX40lOv9Gq4=
X-Received: by 2002:a05:690c:60c2:b0:797:d46b:e86e with SMTP id
 00721157ae682-79a81a90a25mr75990057b3.14.1774016479055; Fri, 20 Mar 2026
 07:21:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320-apple-m3-initial-devicetrees-v1-0-5842e1e393a8@jannau.net>
 <20260320-apple-m3-initial-devicetrees-v1-5-5842e1e393a8@jannau.net>
In-Reply-To: <20260320-apple-m3-initial-devicetrees-v1-5-5842e1e393a8@jannau.net>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 20 Mar 2026 15:21:07 +0100
X-Gmail-Original-Message-ID: <CAD++jLm42TDQCMrrz+8jkBZnKc7-Kbo26Kp8RR+XZhhGyow0OQ@mail.gmail.com>
X-Gm-Features: AaiRm51jFHpXl3P8yRKHiCPd9s1KCUcQyaH7BZV4EXHpuIPKoEs4F89iW4OvG24
Message-ID: <CAD++jLm42TDQCMrrz+8jkBZnKc7-Kbo26Kp8RR+XZhhGyow0OQ@mail.gmail.com>
Subject: Re: [PATCH 5/9] dt-bindings: pinctrl: apple,pinctrl: Add t8122 compatible
To: Janne Grunau <j@jannau.net>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Mark Kettenis <kettenis@openbsd.org>, Andi Shyti <andi.shyti@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Sasha Finkelstein <fnkl.kernel@gmail.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-watchdog@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2026 at 1:23=E2=80=AFPM Janne Grunau <j@jannau.net> wrote:

> The pin controller on the Apple silicon t8122 (M3) SoC is compatible
> with the existing driver. Add "apple,t8122-pinctrl" as SoC specific
> compatible under "apple,t8103-pinctrl" used by the driver.
>
> Signed-off-by: Janne Grunau <j@jannau.net>

Looks good to me.
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
