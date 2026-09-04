Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B10B39D3D3;
	Fri,  4 Sep 2026 20:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788553870; cv=none; b=dGoUwmmRYArqNxiRYWIwr8cHK+yEDMgvNIGw+knbYKZF6dq6JlDjw9UHlVsUObyDxprlfK6r++YIdc/hLueJMSxeK+urwhJ9Am+E+68K6+db73j10G+37qFXpG5FmnYdtycGs5HmWqo6mMi1TwPftvgLApkMK10NpEPXWQNZBw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788553870; c=relaxed/simple;
	bh=bEto9B9KvsIvu/lbcHiIs33DT3QggixuDiJH/7UnUpc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=chjBkGoUeT1fTPapgKjc3CXFheOQlNTb8DBgbBM49pQVhxTn2U9X05tpCJm+0AzqBLs8IhZZ8CuwCy8P4AQ6qagrOnXufEnq/AELW/IshKLYkPTQVKDJ8YLgQiCpVgEG5IHFVokRl2C72mNBfmdkFu8uXm0bc2KuWOHf/F3zs3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D8kFMqmI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D8kFMqmI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D12D1F00A3D;
	Fri,  4 Sep 2026 20:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788553856;
	bh=Q2U2cUyn/uK7/+y8yr8gyghlNU8PH5KerGI7TPqKuu8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=D8kFMqmIALGzBe/uazGT3txbGKSxweOppc+FozSoqxNx/ZQYfV7SoONCHXt2RvmzA
	 wnxsIKpzlmX6dD3vnpDK6I5Kz7Rerp7b5v1Se/rjHQX026l3P3Dq+U535JwCFtHofd
	 VngsQM8KokzswiIDB28U3XMIvju5YygYwlXnb4jHPYlNGXc9NnPvcnGT7eW4jze50F
	 7q7+r252QdRMoCvkpfTLMS+znCWddQ6DM56JZhWpU8RRK5W77OIoWCHlRWESNWf4ag
	 6oWOqY72Wgsgpnkde7MC8z7Mi41p7LV0MD1zWYMgIOxdMAoWgcPDrJqPgqgMlVDEUI
	 h+miLVLYXUPWg==
Message-ID: <f73a94c4-80a7-41b0-9671-d9b6ea436174@kernel.org>
Date: Fri, 4 Sep 2026 22:30:51 +0200
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] dt-bindings: arm: apple: apple,pmgr: Add t8140
 compatible
To: Yureka Lilian <yureka@cyberchaos.dev>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>,
 Hector Martin <marcan@marcan.st>, Thomas Gleixner <tglx@kernel.org>,
 Radu Rendec <radu@rendec.net>, Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-watchdog@vger.kernel.org
References: <20260904-apple-a18-pro-initial-devicetrees-v1-0-0c25401d165d@cyberchaos.dev>
 <20260904-apple-a18-pro-initial-devicetrees-v1-2-0c25401d165d@cyberchaos.dev>
Content-Language: en-US
From: Sven Peter <sven@kernel.org>
In-Reply-To: <20260904-apple-a18-pro-initial-devicetrees-v1-2-0c25401d165d@cyberchaos.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.09.26 21:49, Yureka Lilian wrote:
> The PMGR blocks on the Apple silicon A18 Pro SoC (t8140) is compatible
> with the M1-M4 SoCs. Add "apple,t8140-pmgr" as A18 Pro specific
> compatible.
> 
> Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
> ---
>   Documentation/devicetree/bindings/arm/apple.yaml            | 11 +++++++++++
>   Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml |  1 +

There's something off with this commit, it's doing two things at once 
and the description only mentions the smaller change.

Sven




