Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A323A1A38
	for <linux-watchdog@vger.kernel.org>; Mon, 18 May 2026 22:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779142114; cv=none; b=GluvGdzmg0AQxBiumecJnzjpuO/HE377c6FQf1lgmEeQ7H06OBB2Qz5bFzZEx8IHZG3fpTFSlQvaOQ+E13ndrzLR91gTu15F+fbjZu5cRGwmOy1qZwLA7k7AEKlclSI1ytehmLdCtOKLZf1Ld6NuiB+fJpB8PVFS32YUOPFsEj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779142114; c=relaxed/simple;
	bh=bkTV5Xb/gL3gk0EY/K4D082Y+Ihbg+tpXmPP2JoF8hA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sUgWjpI918BMknLkTKhUEMH7b0MtTQ9bjkZAHRn7hSIv1f50ojreknI9X+8e7CkEy/eyCslSnF0c+fhDwqs0bBk/yHYnzncXBp1i22GtfZT17NI7qkanmZdMATLwIqMv4vhNfJLLjRHEKGTzvHSU5ObkFuMvXuGv8w6z1kNVnEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EuCBM9M4; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EuCBM9M4"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2f7ca62a3c4so2722535eec.0
        for <linux-watchdog@vger.kernel.org>; Mon, 18 May 2026 15:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779142112; x=1779746912; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=DmfUMvPkI43A3UKC7Mf/+0fidnRkZYl9Sq9EgnB7HM0=;
        b=EuCBM9M4goN7Lq7Z3/x4J5oe+yf9zoJZtkS64CVVCwdA2WwGAtymILKfYVb63tHs2J
         0FlXpIeN4sEuW5JXVuEM7428wDT/X+BgWHeQz3ZFJTdAlVuQGvPJKvDdQdxQqdCA07nm
         9Cw0xvgMGL89AFp92qUThHATiH9IIs9ZynG7UEsIiRlpbcaHmKDnYsZDKywrQfwfm7yU
         EDmKRJHfhCSuWcmnGsSsPMlxBmxZsUnSbBi2Q93T6dYx4DDYmS6qtW88UgjOqXed3auA
         M5TOViKyKQFFj6Ue0Hj8tTgxNqsbhEIuZmF4+poC+v6b6ofzRit1jZR0fTw7lEJVDEqO
         8l/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779142112; x=1779746912;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DmfUMvPkI43A3UKC7Mf/+0fidnRkZYl9Sq9EgnB7HM0=;
        b=rqCPlsMJY3hxd3rdPws/K2Njp2DJteEHi2oGFCbcEZi3ZJdzQi+agd4OTSWEi+Sck4
         E2s6ASkjK1Nv/bhBDx9BEm2eN5zZoNfp927/6cBGK2CcZiudgu1it+/s646mgLsD+InB
         rG8dcMANheABH9OYSQuuzW9B12Aks7F82zxUuvTgQknDoLjPlHma5gcswPfNkpVEH7Rl
         YHDf4VknUTzx7qgcdE1sZ/Qr0vbHn420Pu3Xm8wc37J6zcLttX6ZpXLv6j60tH1KS9rf
         3ib8QtQzDpYTUHvtHtYQz1JE8aZVkcH8X5Gfql55ClMa2k/NrQMwSpsUgHNqeKJeL85E
         keZw==
X-Forwarded-Encrypted: i=1; AFNElJ9tFtx9l0IpVDCfa1Bdr2jB5iMoWDIlxt+kGyVYmG3zRrMYMO4Vxy1/bXRPl/J7v0kc3K8Zi8fqikrBj1Wr7A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ0Vg00RZtPSTGmedD3RUXwi5GD/gDGj2QCc6xvSGrixeqwxFV
	SYqcfnyt8OTUpN7JHblc9dVFSqY7C+neyugKLrMEu4os+fQqRRS69r1w
X-Gm-Gg: Acq92OFyhFSBZQJ3olFGTY3uBWvHrd7LdImWsMU99FM4oP9hE1qveSiduVE7vd8ycMp
	twlemWnmegrxqeBYWMPSiHvTyndlTGjNZI1nd6/4MKjdfqn82ks+UKBBOQc5+ZM0EFMCCj0/Ppf
	mh6JyXyEmZ6HPNCrXNzDRPw3sHG0vsz9J3SxxehcFsBAYTb6px1b1hA1k7Z36tLDI/bLG7nCN7v
	EaR7/dT3pX+8jadmELH8916FAwc3dKGM72od9dC9JO9BJexQltHNzXjMxi2FG1IqRvvJIrW6jGs
	rx3nMktcxdxizIPTmco/kZw8R7T4vcVE26AFDS47S+5mc/KaREYGKBLcmJsFHQk9h+fOVidcCwR
	ZyUcLFvfe03wIfcLV9tLVHMkfBLGHhywwmfLYeMoweTNBhAZxE7x+Ife0EJjm7qgHCRQhcdRIFm
	7oTDCFZ6XhBgtPfW8hyxyVvC3/JgMdfBjddKeXpYL41ADLb8a4b/4QgCliSpVMHgXEt+tFWCls
X-Received: by 2002:a05:7301:7c12:b0:2ed:e14:7f57 with SMTP id 5a478bee46e88-303986c651cmr8587486eec.33.1779142112232;
        Mon, 18 May 2026 15:08:32 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30294adddaasm14705751eec.13.2026.05.18.15.08.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 15:08:31 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b53c175d-04d1-420e-b9f9-e191851b4950@roeck-us.net>
Date: Mon, 18 May 2026 15:08:30 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Please update watchdog and watchdog-next branch references
To: Mark Brown <broonie@kernel.org>
Cc: Thierry Reding <treding@nvidia.com>,
 "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, "wim@iguana.be" <wim@iguana.be>
References: <d6b1c417-1e3b-4d5f-ad3a-6de1ec23a8f2@roeck-us.net>
 <b229c4dc-7d23-471e-87e5-1bb822f97237@sirena.org.uk>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <b229c4dc-7d23-471e-87e5-1bb822f97237@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/18/26 01:00, Mark Brown wrote:
> On Sun, May 10, 2026 at 08:49:25AM -0700, Guenter Roeck wrote:
> 
>> watchdog (fixes):
>> 	https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
>> 		branch "watchdog"
>>
>> watchdog (commit window pull requests):
>> 	https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
>> 		branch "watchdog-next"
> 
> I have updated the watchdog tree and added the watchdog-fixes tree from
> today, both with you replacing Wim as the contact.
> 
> Thanks for adding your subsystem tree as a participant of linux-next.  As
> you may know, this is not a judgement of your code.  The purpose of
> linux-next is for integration testing and to lower the impact of
> conflicts between subsystems in the next merge window.
> 
> You will need to ensure that the patches/commits in your tree/series have
> been:
>       * submitted under GPL v2 (or later) and include the Contributor's
>          Signed-off-by,
>       * posted to the relevant mailing list,
>       * reviewed by you (or another maintainer of your subsystem tree),
>       * successfully unit tested, and
>       * destined for the current or next Linux merge window.
> 
> Basically, this should be just what you would send to Linus (or ask him
> to fetch).  It is allowed to be rebased if you deem it necessary.

Thanks a lot!

Guenter

