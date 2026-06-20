Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B6521A92F;
	Sat, 20 Jun 2026 11:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781954608; cv=none; b=CEuAJolbQbsEhlsMOvCj1ufkmy5sCfYAViAegh7/iIR2W/6PqZKTK3v2MYQN5okOLTJGIoF9fqqG5FmiNU/J6Q1AvMWKOfxgRSXNiqBGTYsZYEoWriBYpBt69WIatPigQC6rKluaDZh68j+O7uowyNUTRsBLZhR/9b2CRv2Grw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781954608; c=relaxed/simple;
	bh=3L/yph5/LBTtNXjBoCbJpFYnT/KOscw4Z0iegKGlYuU=;
	h=MIME-Version:Date:From:To:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Rw+lpcCNDNwfJ3fvI/ccG4oY+ydYpEJkK2fS+h8eiIGIIJyC5lfcvg1wP6PzkeJtYRl6w2lmm70x5xjvojr740ytjFuxa4hB77H/YlANL2GhIBA9Z15G1WgFfuJr2pEPYp/jBjIvp1lKJXHkDO3K09Fd9en2AyWaxGt+muv20mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=YMEU7Iyo; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="YMEU7Iyo"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 99DDF27753;
	Sat, 20 Jun 2026 13:23:24 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uCzOHHyJas7L; Sat, 20 Jun 2026 13:23:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1781954603; bh=3L/yph5/LBTtNXjBoCbJpFYnT/KOscw4Z0iegKGlYuU=;
	h=Date:From:To:Subject:In-Reply-To:References;
	b=YMEU7Iyocc9mDlHMmRZsX4xqIXE+dnNSbPuloOO/Tjd7W8DPvYohm9gZaR8a0ef1x
	 adQyZ5DPN1eM9339G8UcfxG1Hocv2gokKU6HQ5c/djsgPglcu9P5u/Qnbj8MawsVlL
	 QRsq3TD8hummMu0A2iq1/HfjBvbSOBy8NJbxm8QfYkMo/sMfuK06npmiztKE3SrLkw
	 FbwA5RaXp+MddDCx0bqoDMRz8CZUuht/G69hOeAU2nQRHQlbZEv8fK2oaWLuK7fIvC
	 Aue8ryJp8nBMFs8ogtcD/IwPScL6pDeRfYSzPH5jhwSM1exSixsIDNckJI2naJi9Cu
	 MJg6+uBiua18Q==
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 20 Jun 2026 11:23:23 +0000
From: Rustam Adilov <adilov@disroot.org>
To: Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck
 <linux@roeck-us.net>, Sander Vanheule <sander@svanheule.net>,
 linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/1] watchdog: realtek-otto: Make use of regmap API
In-Reply-To: <20260519182329.24472-1-adilov@disroot.org>
References: <20260519182329.24472-1-adilov@disroot.org>
Message-ID: <05dd2b1d95985e303af332ec81cd830f@disroot.org>
X-Sender: adilov@disroot.org
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hello,

I have noticed the status for this patch series is "Changes Requested"
in the patchwork site but the maintainer opposes the requested changes
by Sander in [1], so what do i do here? It is just one the roadblocks
to get USB stuff supported for Realtek chips.

I have already sent a reply week later in [2] but didn't get a response
back. Maybe this email could be served as a gentle remainder.

[1] - https://lore.kernel.org/linux-watchdog/1d5091ff-e497-4b5a-a906-7cc02c31c4c0@roeck-us.net/
[2] - https://lore.kernel.org/linux-watchdog/b4b09be5ff456a23d15a5af3237b9b46@disroot.org/

Best,
Rustam
