Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6512D949F
	for <linux-watchdog@vger.kernel.org>; Sun,  7 Jun 2026 16:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780849738; cv=none; b=pGNqUc/Jmps8HuKSiVq029Pi1USmNRIjEhIKZqhZThYQilS7+rxNKNitmJGN891icTrGCkI5VTubSkB5lGKug4GIZFbexbBwgNo3ea2KYb2qgDFjqgGoBKx+ByGTYQXxFdTAOxwqMRhhIF8GeolXUrFzruWq31L2OB70dXWKF3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780849738; c=relaxed/simple;
	bh=76jLdYmKKvRiHybp+BbLyLCAjBd7s1dj4rJc42ZhHos=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NHKHzBhoE7FaUDse9Xx7vdrzs3mKXu+RmVaNn4cPhOUsTwQ7Wy6II7eCwuQDvwr1We0ZHl6ooMFYMkGxFg/1ZzckbI1CtV/bnw0RzKjV+oFerDh6LabeO0ynKsyCV0vqllW22HwI75pZCKCfakwZWvUzFHEHJUKfwV5z7+Z+DVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MooF9jxl; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MooF9jxl"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-137f27712fdso2897638c88.0
        for <linux-watchdog@vger.kernel.org>; Sun, 07 Jun 2026 09:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780849737; x=1781454537; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=hJpHWJSLWsGSGQMR2ErZayTJOUs27pd6wJYYy+x8Ozg=;
        b=MooF9jxlftK/j2N9Kx2Cj9BcC259s1tVR3yNt7VYYdqM0xFTtxtjUXY8oxMecNYL0I
         GfcM3HoBHhfEo9M0FYKNSKGZyWO0k5Al3G38foe+sf9IivkGNhclxL2LGjohrhfttOHy
         pUBLJONQ0E0EOsjLlGWInb4OPPO2dGTjzDAOYTGwSPIZzD6q8n1Ms5VR+ILPmCNmUpyT
         0eLSq0UemarsUxyb1KL7XXaLiCebGUQkoQKBwni1WU+UTJY8sFyApkzfDWySNNpIQQJH
         P9MPLWOwl6sx2KTsUqiM06cp5EL/cDBEva96wJo3BZuksuem8YWETOvB5tX2Y2F9plaF
         F8Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780849737; x=1781454537;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hJpHWJSLWsGSGQMR2ErZayTJOUs27pd6wJYYy+x8Ozg=;
        b=VR0YU1i07RRfyGuDA+MWLoreF2sf+6rfvsSiP6lpYTEqSdwIXWjb6CqNuq+vHWHE/I
         tk7QJUxj4rcD6oKzZ0USJCroBxy0QpoXyifDR9OM1qmRnZmk7MkE2Xvv+M0xCAn8Smt4
         NhkbF6RNinX6sm1Egng/1WhqnE1bGrC84MwzCRduBXpYmt/Drfa9yzJ693mfeLpZspSh
         nU+o+G8dNUhQgk7k50RVdKtABtcvCvYRnpNUwwsnnXXLw9ypJRPiGNiXFvE3qnI92nJY
         TVWqNSEgbpzOkLM0vbKYC2KjrkFWsCfE2iIvGwjQJeg07oiHZ0IJwJmbpH1VHWzQg9YM
         73rA==
X-Forwarded-Encrypted: i=1; AFNElJ9K4LPSe79Lw4Y6qs6B3lLcHm8aMG7al68fBhOWlBDFfgD+8NxsT80mpOvsZ+V/FVBbiUVqlseE1mzOn307Ag==@vger.kernel.org
X-Gm-Message-State: AOJu0YxF6rIxox8I/PhKR0dVbiq4aygJDjRIyxLWYzJaMpl8uSC57ROQ
	6tAZPcz7D/iTNGau3fo8LVncY+l1t303K7UERd9dBw07++XkXGlgkvLO
X-Gm-Gg: Acq92OECsVHplxbrKt3cOCgh5tcwhlA/k60VInOiVQeyoA0UENZJsCpPIGemy3LsPvP
	9QIKZb5d8628TPGTg/Tws26PsYao7rbb9OBaJ/OPbLu/kZvLdGIpW4oHMdyevoGOcp98mxKzbgE
	GJ1X9MV6d52qym8uJbc4jqmPqANtOcOoIPplupKtpitGwRCwjhLniOyXB4Unzp67vWFLfZfSNCs
	AaeqDbjGTmqHesco5YWGkMc+mfPEcFH/UrI6L0RbWmf5GuBR1ZMBcVmtvaQCRClFM4x+Z1x6dzP
	fRNEeK7GVG+EYqgdxPn5mL1MTfYUOyPJi95tGlD1GS5gie+sV78X+okJ580yBCGbJURsZ55i96/
	1+pttqn2ANRN8UT+rM6DzN5E7GamcDeFOYu5jEUe0wWeL9TrFQT8Y9+F/CuZ6+djYytnmQHcC1s
	yy9mligLqpyM/R/Dp67+kF0QcBm25THiFPdB87aQmrQUsp8NlSxzd9f2qpvPxoGZ7OiLhlYxi8X
	92XlqBrjhg=
X-Received: by 2002:a05:7022:618f:b0:12b:ec67:3529 with SMTP id a92af1059eb24-138066c0641mr6765440c88.14.1780849736641;
        Sun, 07 Jun 2026 09:28:56 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137f716017esm14887247c88.15.2026.06.07.09.28.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jun 2026 09:28:56 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <462abb50-60e1-4e6e-959e-240cc4ec1e0f@roeck-us.net>
Date: Sun, 7 Jun 2026 09:28:55 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] watchdog: pika_wdt: replace in_be32/out_be32 with
 ioread32be/iowrite32be
To: Rosen Penev <rosenp@gmail.com>, linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, chleroy@kernel.org,
 open list <linux-kernel@vger.kernel.org>
References: <20260602035620.623085-1-rosenp@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260602035620.623085-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/1/26 20:56, Rosen Penev wrote:
> Convert the ppc4xx-specific in_be32/out_be32 to the portable
> ioread32be/iowrite32be. Also relax the Kconfig dependency from
> (PPC64 && COMPILE_TEST) to just COMPILE_TEST to get build coverage.
> 
> Assisted-by: opencode:big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

This is an old watchdog driver, not using the watchdog subsystem.
Please leave such drivers alone unless fixing a real bug.

Guenter

