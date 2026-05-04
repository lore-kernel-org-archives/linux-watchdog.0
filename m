Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AFC3B19DB
	for <linux-watchdog@vger.kernel.org>; Mon,  4 May 2026 13:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777902276; cv=none; b=fDHb9yjbBmzqheaGhySPeoh/XTgdGp01i4jX6ty4gbfbwjL7oZZSWAAD+G1oX8/yoKDiu7DDvK7voP95/0IJ8Buv4VZEUyXZF0Ea9QaftsBzKaAHKY0/Y00JM0QmrB97IunZYhgc5u6I3iKRVQ9bf6108ggaM11RhSksKEy3NSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777902276; c=relaxed/simple;
	bh=SUWab+NO56yZc018FgKhlh+Age/SbMHtL2ESWxwSYpQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kv9xQR6rHkgd8RxjsyCti4/xfREjF15eW7c2z5bihv3T7OTAMWVENFjqKnArISe6CnKYOxObLOKQFigE19oj8/rfCk3wyPCu4YqNTejJiZfLwaAKgmrLurEbIaaD2MD4Eh76YfAJnX5fvfEaqvYWHHUVG9Wc1KNHBucMdUBbsiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JeMkRgDl; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JeMkRgDl"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2b4520f6b32so6160765eec.0
        for <linux-watchdog@vger.kernel.org>; Mon, 04 May 2026 06:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777902275; x=1778507075; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=lec/HBRFhNgtqkowgM6Ks1l+vLDAMplL7Wo1YC7WXGg=;
        b=JeMkRgDlA5cf1LLRUmMBVev65N5QPo7CO/GAYbQYw5BVd9v/fDKQOVvlVF450ZqcXA
         IwxHn15v1yLjKa9E/PkSLXVzmdS/UpZ3NRJp0xfxACzHF0/E1AfGakSKnEh6GEBNmuEV
         ldu8E3fXNXgGzmqRDu/f4Xmmj6Xxdn9QrJxA5dIdvtRfJr9vZoF/8xi2ZYwsHPgsiWvK
         fdBUok+Oh8fDDsaiahThWlo2xdOWK+XHCLW53uU/tB22gnBIEC4bk821tacrvUE+B1Wx
         wmAo+K6f0R1iLHZje9PlxLSHeZbOhxqV00JhOWsR/T4F1F26XIXg9k3qNvmQqFRTGrLV
         vPmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777902275; x=1778507075;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lec/HBRFhNgtqkowgM6Ks1l+vLDAMplL7Wo1YC7WXGg=;
        b=bdEx6/xoOx+Qt6FWA7TRVK5ADM/3mpe2M8dyqVR7LlE40AQco0LSz0NKiOAzYki8dV
         r2j6eFnX7SSpnUEr+vHD6A93OJMA9ygXfB7QPln1b9uYM2HQASnLY9LQffeHb/JVhIHx
         UUxw3paF9b5azbrMWUkbJZLTRdUyC1nB1i2BYAIp49rJ/egn5st385pjxkzk0nYvbJY5
         4dyGRSqxhnDMzvLbTF+ZI5uXHFWIaLBAmBCbSHjkNLnOarZeO9WFCwyo9LD9ur5cF3U8
         54Wc0JE3HnLSPTqF9GC8avSDD/Y21qEE00ke5QIrvZQE0ErSRQdISN/2ZB8PrJkGEOxs
         5gKA==
X-Gm-Message-State: AOJu0YzOUAdjm7xaoIecDXfzzP4I2+IWNsMAyhU5qB9lElRQSr1s2k/8
	39a3RmRPkJIGNQEZ2pFs/Jca2nfeW7DD2Do9/wkmyVSr5K/SKzKIXdh6
X-Gm-Gg: AeBDievTpHj5QP5xzbLee0OZdZivmX1gf89sQwwi0lq3dSDjC1X/BM3zPn1CQeIVEkQ
	+Fqe/BOuUzNg5rDgpNfXBeczQPVUEzLYfZoCDrexgLBtydBjoRwmdmhxqUSPs7m8gbFdRC3JftL
	Q/sPuHJthPpyxD4+D8rFFU17KeBbgF0P5q9QiahxMPTWQ9ej1TCzBrsvZVM2GR8GeaNiRg4JyPP
	6U6IooSAFseUXaWLhnLKLbDB04Uepe1fkyflAsnRcLhfolWatdO5iQwr6m/ucWp0zgdAvwj28sj
	dPqApNRobyGjySHRzqsE44Eq1uOAKwbu5AB1gQKi3jBgfsxp6fAPn6ctHqBLcGKijIc54ZeHgPp
	tMr07R/gTToWNuIDQrizmUfe8yKGOGR5SSHiIEVOeg5sy4SnsBA12XRpf/VTJtYFSUmQkgqGgDx
	Ecs/SfNHSi7ijrXqjJoev3yNDsYOrKzaq675JLJbM25WnSi5GoILJBEKvVDZOXwZrrGdbngM6hs
	Yy0vHQjwTo=
X-Received: by 2002:a05:7022:ebcc:b0:12d:b396:eaed with SMTP id a92af1059eb24-12dfd7d1a3cmr3566772c88.9.1777902274310;
        Mon, 04 May 2026 06:44:34 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12df8424ef1sm20213769c88.9.2026.05.04.06.44.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 06:44:33 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <232833f9-5542-4f4c-9bdd-92f72b0597d3@roeck-us.net>
Date: Mon, 4 May 2026 06:44:32 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] watchdog: Fix wrong SPDX license identifier
To: sashiko@lists.linux.dev, Philipp Hahn <p.hahn@avm.de>
Cc: linux-watchdog@vger.kernel.org
References: <5557c8ab4a62750c95631f6f78be7d2b11e091fc.1777892508.git.phahn-oss@avm.de>
 <20260504111735.3D387C2BCB8@smtp.kernel.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260504111735.3D387C2BCB8@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/4/26 04:17, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The commit claims to fix a checkpatch warning by replacing `GPL-2.0` with `GPL-2.0-only`, but the kernel's checkpatch does not warn about `GPL-2.0` in this context, making the change unnecessary churn based on a false premise.
> --
> 
> commit b8d17764218e572db22388434473471ed009998c
> Author: Philipp Hahn <phahn-oss@avm.de>
> 
> watchdog: Fix wrong SPDX license identifier
> 
> This commit updates the SPDX license identifier in the watchdog
> documentation from GPL-2.0 to GPL-2.0-only.
> 
>> The identifier GPL-2.0 has been deprecated in favor of GPL-2.0-only.
>> Change it to silence checkpatch.
> 
> Is this description accurate regarding checkpatch?
> 
> Looking at scripts/checkpatch.pl, it only enforces GPL-2.0-only for files
> under Documentation/devicetree/bindings/ and include/dt-bindings/.
> 
> Additionally, LICENSES/preferred/GPL-2.0 explicitly defines GPL-2.0 as a
> valid identifier in the Linux kernel.
> 
> Since checkpatch does not emit warnings for GPL-2.0 in generic subsystem
> documentation like Documentation/watchdog/index.rst, does this change
> introduce unnecessary churn?
> 
linux-next$ scripts/checkpatch.pl --strict -f Documentation/watchdog/index.rst
total: 0 errors, 0 warnings, 0 checks, 18 lines checked

Documentation/watchdog/index.rst has no obvious style problems and is ready for submission.

Please refrain from unnecessary churn, and from making false statements
("to silence checkpatch").

Guenter

