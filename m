Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A43F79DA;
	Mon, 23 Mar 2026 00:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774227268; cv=none; b=Ep2I/vuLCyK2U8iBmnjnyHMGexXVGs25tWV4U+QkerHfEL/xJ4QH6H5vDqjl82MB4mysDKARxLHa64GOOmcTwm3HVLE+WvdWhJhpU8+2ZHQJ5bw5ucarPSYog9p5RBvgoxE6NEb4Z+AjaTCoiN4knhRoWyuBRiIDzC9jQBfQ7WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774227268; c=relaxed/simple;
	bh=xPO/6bhmiA7gIWQYx6HkqJrKJGQ9iHDbpkPgyQJOz5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eTPkPmaA6pOcKJg5OELXpU+FF8ov4GhhQgOQisVaPs8eFVh9Ij8XkX62hM+Yceaqi/uG+boG0vmhG+n0T1wjUEFUSnQuTb21qVk6j5A+yZc/2A7kgqqXhmPIXpn9FPqQKur4ocvx+X5Bf6wBCNU+04GRjEydu+8lpdFwCZwFYS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=z39ouZfK; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="z39ouZfK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=KbF/EUcuG7n05dH08Ijk3cZz7X2uy0K29wMkIptsrKw=; b=z39ouZfKT2QkzPI0uyEbwmv9xf
	G9sTOvXU4JVSgCNahIHj/hnzCp2s9RYUhfwzrUbr1G1BoZmDI+qMwxmGo8vNaD5S/Y921hqZtpIlT
	2A03+YBYF8SaWxEFixZw3ZTMBui39nvOERCn4Gu9NqHVFCI+ylXjqBNI76mxC4Q/CQZiqG0jkE9U2
	F/wzCNTraoBGqHL7SW2bx8uFlpeFPgcKbeg5ga1/5sEilByU85XXAn5G9jPDUgHAq9sH2gnRzMyMX
	B3t1LB1FMVnYG7b21rdAWfk/B+Mea/Ghrdf/j7S1K3yzsEQGSKkgNQTatS/NIJrAHbWUr824VfR9B
	vasYfNEA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4TYj-0000000FnjE-3vPB;
	Mon, 23 Mar 2026 00:54:21 +0000
Message-ID: <3de4c724-39bf-47f9-bf43-49552bc60a3a@infradead.org>
Date: Sun, 22 Mar 2026 17:54:20 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] docs: watchdog: general cleaning and corrections
To: Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
Cc: Shuah Khan <skhan@linuxfoundation.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck
 <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20260228010402.2389343-1-rdunlap@infradead.org>
 <875x7cddye.fsf@trenco.lwn.net>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <875x7cddye.fsf@trenco.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/3/26 9:23 AM, Jonathan Corbet wrote:
> Randy Dunlap <rdunlap@infradead.org> writes:
> 
>> Fix some obvious issues in the watchdog documentation files.
>> I didn't try to fix every little niggling mistake.
>>
>>  [PATCH 1/5] docs: watchdog: mlx-wdt: small fixes
>>  [PATCH 2/5] docs: watchdog: pcwd: fix typo and driver info.
>>  [PATCH 3/5] docs: watchdog-api: general cleaning
>>  [PATCH 4/5] docs: watchdog-kernel-api: general cleanups
>>  [PATCH 5/5] docs: watchdog-parameters: add missing watchdog_core parameters
>>
>>  Documentation/watchdog/mlx-wdt.rst             |    4 -
>>  Documentation/watchdog/pcwd-watchdog.rst       |   19 +++++--
>>  Documentation/watchdog/watchdog-api.rst        |   38 +++++++--------
>>  Documentation/watchdog/watchdog-kernel-api.rst |   20 +++++--
>>  Documentation/watchdog/watchdog-parameters.rst |   11 +++-
>>  5 files changed, 58 insertions(+), 34 deletions(-)
> 
> Wim, do you want to pick these up, or should I take them through the
> docs tree?

Wim, are you active?  Can you reply and/or merge these?

thanks.
-- 
~Randy

