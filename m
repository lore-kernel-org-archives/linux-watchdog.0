Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87C735A3AD
	for <linux-watchdog@vger.kernel.org>; Mon,  4 May 2026 14:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903889; cv=none; b=nLbtOUjyoNInJXh+uh307zUFfB4/fgSe5m141zVnC7ehC0lCZYzflvlXa9CUc4lzOacZtlPhkgk/LpSsNXThjOe+IOuB/UIegNjCuuRktnYozPL4J8D7tZ8FNhoH4G8j07vpusLxeE/9IyWYR8F1gjh34SUy834iQ6SKRlBtyTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903889; c=relaxed/simple;
	bh=wXXpEQc9x30X0qg5Z6HGj0zyIUFo72oFGCUTCaDm7g4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FfEIDIWcGFX5vmrPdpHa+4jEMbe1FaOqaMx4tEHq0jAzf2NWWFDs/BK+z0cyHppVEufd50NPtrRzncem0KZxPFjjB9tXVzkoG7MnmFsRYoa/Y/2IBqoczMQG4/fiZwhkYoSR+kCGlAu/irsPl6LKmepXkuiVjv2W9oyaVUNqt24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LkwrJ/SV; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LkwrJ/SV"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2c156c4a9efso6887574eec.1
        for <linux-watchdog@vger.kernel.org>; Mon, 04 May 2026 07:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777903888; x=1778508688; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=L+DIvmTgHmOKPTVnBRAWjfnew4V3iUKxG9iUGvSM7d0=;
        b=LkwrJ/SVai+GGyp0BOr/fH03gMHhlRfQnx7CGWCgWis+QADU8Z0KQi7myck4I/JwWY
         20kwfth3erhu7x82YYIY2DPGBBWze4Zy8Vn10yPP1kZD+T6+Evcw7XqHwGRwVh7TlelA
         gzh8gb08bVstJsKB8UwIs4A+LJkMnvpPLSG9AyX0xZCstpuJgoQLpH9rLLU99mhSZmkk
         aoC5Xx5Dm+vhOEhoCiteUop7LJhnNOwu9sEIqPDmOLstDd3j89docqc/1AHYvv8L3kdR
         PtwdBpL+5PQSmgHsrOSk6NcFK4g4z4h3BddXDjd3hipySe1bCYw9vFG/8RSHem9dhDrD
         mCpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777903888; x=1778508688;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L+DIvmTgHmOKPTVnBRAWjfnew4V3iUKxG9iUGvSM7d0=;
        b=XYoYnXQTLMTXCvHoXG45Xrlj6qxaK4dUHRTlSl1gMr+E/w4Is0zuSrQBo0UKluGFRD
         EazyFNtHTnYASBwtMAlMAh5toeoGA7cXFaAzxmu4T6CkglOYCbUufeuyKD7N37ckqef9
         s5XNSH1a3wkdwpp7S9Ke2xvoD861vB/fY2MJ+u1N1LJjep+o3sDm0tNfaNSeMhYJxUR+
         /FoUH1D4Pf3snalBE4aCPkT99+L/14MCaQGaO5UK2Qj2dYZPMHKqK0/CRikYXFGF5L/U
         OZfxfK3Wl/xcmCPJX5tc5eY/c1OkMNGvxTcGd4O3ywmfRN4bHdx8syq1lBVkQuThK6sY
         ovvQ==
X-Forwarded-Encrypted: i=1; AFNElJ8lwxFCJkCmjsCECFt8vguls9X7Ix2sN1F1Dhv9uTlIifYQWz0LFhnD22QN2AQjI1KEhiMKa5/6cs9tQfVJCQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzXuCxZ9SSJoJonfcjISX00JaLyXHH8zrkCJjOYQ5cBBhdW1RWM
	WUDFRwz95ZbgPINFxl03kTfws2I0Yz+P2XATWWRU9MAPPyaC37VbcvM9
X-Gm-Gg: AeBDiet1n/gs10wJBaBaUGNMzUgB2UX8tU9YuCyKqMz6mLP+XYki1Tzf8T7uo8z0E1N
	pcqLW8eYU6xtwRJl71ERusH7YyjS7WKC03nxGIReyKt6xd3OUlJm5X9PV8VqYj2GOI1T5Lm6W5i
	was2whP20ey/OPPuislacNXY3YtJb4pwmHgOWPYdJNO11BS3PbuteKN5WfZ5N7oNmigj3lcUTwE
	OvEMqKYSWSQfIphoZpuksz/Kb2KkDVUfDab1GDyxIKa5hITv5KYwSwBgkiTC6MbrBdlpWm5sk2e
	+2v4YE6XH3XMP/on6Qyntuk1A2cTs7lunfNk6P6yZr1IWtrMTNS/6x71g2NubUR7fOmPdwjuKpt
	0gFFY0c8O4el+QsDwcxgy87XIGGgUlMOoiIfWo6DPpfHDxeMLYK/S9A/2Rse+bQLVpgWN9RT4aL
	N1ZEEh7KbhR9fOjLE22j0Upqlw628sA5rUoPZvbO6TgzNvrszV9poVhLd3mmUW5XhN3gFf32nqT
	/ArHFBSHDA=
X-Received: by 2002:a05:7300:7490:b0:2e0:909a:b9c with SMTP id 5a478bee46e88-2efb87a8d28mr3924903eec.15.1777903887557;
        Mon, 04 May 2026 07:11:27 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3537d300sm19477618eec.0.2026.05.04.07.11.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 07:11:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <2f3ed933-042e-4797-9baf-0f22eeedc632@roeck-us.net>
Date: Mon, 4 May 2026 07:11:25 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] Cleanup Linux Watchdog documentation
To: Philipp Hahn <p.hahn@avm.de>, Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: Philipp Hahn <phahn-oss@avm.de>, linux-watchdog@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1777892508.git.phahn-oss@avm.de>
 <cover.1777902230.git.phahn-oss@avm.de>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <cover.1777902230.git.phahn-oss@avm.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/4/26 06:49, Philipp Hahn wrote:
> From: Philipp Hahn <phahn-oss@avm.de>
> 
> Hello,
> 
> while reading the documentation on the Linux kernel watchdog
> subsystem[1] I noticed some strange looking formatting: `struct`s are
> detected automatically by Sphinx and the word **after** it is considered
> the name of the structure, but the watchdog documentation puts the name
> **before** the word `struct`; this leads to the wrong word being
> emphasized.
> 
> Also reorganize the index page to better separate the documentation on
> generic infrastructure from specific drivers – which are mostly obsolete
> and relevant for historic documentation only.
> 
> Please apply; thank you for all your work.
> 
> Philipp
> 
> [1]: https://docs.kernel.org/watchdog/convert_drivers_to_kernel_api.html

 From Documentation/process/submitting-patches.rst:

   However, for a multi-patch series, it is generally
   best to avoid using In-Reply-To: to link to older versions of the
   series.  This way multiple versions of the patch don't become an
   unmanageable forest of references in email clients.

... but you did that anyway. It also almost guarantees that new
versions of a patch series get lost.

Guenter

