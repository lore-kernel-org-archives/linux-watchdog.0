Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21A0439348
	for <linux-watchdog@vger.kernel.org>; Wed,  8 Jul 2026 14:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783522720; cv=none; b=iC58dyXx8BOmA56p7s3BzMvhjamoTVtbJDP5FIkHQq1JbINw4uDrFPB3Nti10Um64oB2Ih8knTiZFic6pytYhTQG/68inLZalaF4V2pV30Zw1+avjswGAkrq/O6QkpN0x5s5gF/ziLLpX7ubJV6Y2+UJJHg9vaxaGN1llbxhn2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783522720; c=relaxed/simple;
	bh=TJa2bnnD6uW+90ZtVENo/QNcA1NbAMQ5ZlxfxZKuh3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G8JYWi5tLZEmbV60sJkF6S1p/Eeu1t/JrT0sPVuu76z2BX/KizsRvxizrd5P/h/ZZfl55E93hrKEXViC7AKTe7KUlLJ66MaihYKepQyrT0Rn05B3U6w5EgEbc1beRD5n1pAum5guaZsiOJd5FnpQ6ae02TWBk8SjhDkaiDRlNcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WdE9EJN0; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WdE9EJN0"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ccdb73f0e1so7991125ad.3
        for <linux-watchdog@vger.kernel.org>; Wed, 08 Jul 2026 07:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783522719; x=1784127519; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ddJ5tgmCYfmD5WoirxiYQqe/FYIqXBWQW7x2IE4xIMo=;
        b=WdE9EJN0cmb6RXu3Q88lZlbPcYElQS62r1gKcQK4VgPHFPjQ9SzgJYJ1EmL5MRTDvr
         grNv54uk3JAm4l62tuPL6MesJ0ZctG7+n8GUuNmjO/H8TSb3w2ZPLmOVodAqNNtvoTud
         d/Z6XK85FEC28zbPmqjRwqOUvcUvEZ/KJDiDGTA2GsZf0F/Wxv0V8NOnvytHwFym/DGK
         6IIbn03ZA4jufPieNGLo8BSlS24wGLqh6ga58Bb0Odhxah8+UDwO7+sH1MySgdaSU2mn
         BH0hyyeOv4Us/VUNoG4Yh0oxAt9QeXU4rxFuBQgH3JdBw7uIJgQbr6+xzfEbNdkgIC1V
         xWyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783522719; x=1784127519;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ddJ5tgmCYfmD5WoirxiYQqe/FYIqXBWQW7x2IE4xIMo=;
        b=camNuT4oOqyUDhjgdJSsA6iVASoMASL9Z1qp2/hF+HmTdSwZHT+UgOHs1NJtlx02Lt
         crd5RclU365gwNOR5pO9pjb+wt3oRLPi+zCdBE2conpBhfILNgEf5kD6gc8ICh5zkVf9
         lrLfEE/21pZVw+1+V0vUziy/UlMA/phMjuqqdxyphpNM6hLTYfUwaUWNTQ+8gri1MAap
         0UHr6UHqOFLbZRWNsS+38oJ9g4x6UMIdvraXeGUwqV6Wg9rQJLZHMMfAFLp+tBXGiHcs
         AyYsmKRqsQiCHXoJ2eSZdzriTSROOZm4FR+AGDDGXvZO0lK01S4aNZJrAJttDZjwJsfH
         r32w==
X-Forwarded-Encrypted: i=1; AHgh+Rr23sodaetf0fi/nWcrQfO6k5r1DIGWwDHfW2/O37hOqRll6bmA+F+aiEOVEKpKZ79IhXOMEyVl3VztruqLbQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxVqCphUXKP+OUIs+4Yb1zWjztOoCC2XXJUdZ4DP/ponbcAeYjx
	1/IsYmp4jFhvIbFYfa0lp2q1QxDzb+tvxR+GPXbqZCe4uh7PV1aE6MEZ
X-Gm-Gg: AfdE7ckQZSXHHPX0krkKOWMaBFjuJ4k3DugmuEAWiWrmqoV/qNi4lmtS1S8y29kHW35
	hPsyvsNcZbMMihZXz+SUtYOS1+Eh0yHX+thh633m7/0fK8qjzxZTEtkJWiXB3ecMNEa12TcvSlM
	BgTWck2+MEBv0na6QfYBsUQlb+h32arC8UdV736hBArBoSXrKrcEaNaQR08td4ysc1rkTYQBk8O
	pyJOTlyjBckcBCdfw89Tyj8ZF+BrS9izlWDZJBLvgZhCUeb9fsjt9lEqMgqK9Pee7h7qfMKCDyY
	GV5tKwUF/ULTvfkKnhSOG5W+feFY3hW94K1glC6/esCnZC3QpFqUuAGLb4Pof92Ov9L2DCOF7mq
	XX8lgAxsPii1ac6Cd13r2v86haZPD/mz426Sxpu1oo5VWrAYQjynkMsYS/HlqNfM1N5YIIXPIpa
	afhJ+wyo2vbCZa5eJer9w2n5pyGg==
X-Received: by 2002:a17:902:f550:b0:2cc:8267:31b5 with SMTP id d9443c01a7336-2ccea3c386bmr30259015ad.19.1783522719124;
        Wed, 08 Jul 2026 07:58:39 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccf9b78e3asm2768865ad.69.2026.07.08.07.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 07:58:38 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 8 Jul 2026 07:58:37 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Paul Louvel <paul.louvel@bootlin.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 2/3] watchdog: w83627hf_wdt: Report the probed chip
 name via WDIOC_GETSUPPORT
Message-ID: <08119f90-2569-42f1-9300-f6744083dca3@roeck-us.net>
References: <20260707-w83627hf_wdt-nct6126d-v4-0-829e5f63d548@bootlin.com>
 <20260707-w83627hf_wdt-nct6126d-v4-2-829e5f63d548@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707-w83627hf_wdt-nct6126d-v4-2-829e5f63d548@bootlin.com>

On Tue, Jul 07, 2026 at 05:45:02PM +0200, Paul Louvel wrote:
> The watchdog identity string reported via WDIOC_GETSUPPORT has always
> been hardcoded to "W83627HF Watchdog", even though this driver supports
> a wide range of Nuvoton/Winbond Super I/O chips.
> 
> This is misleading, since the driver itself correctly log the chip name
> in wdt_init(), but could report later a different chip name with
> WDIOC_GETSUPPORT.
> 
> Instead format the identity at probe time using the actual chip name
> that was detected.
> 
> Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>

Applied.

Thanks,
Guenter
