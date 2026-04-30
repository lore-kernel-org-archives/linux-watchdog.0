Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BBA398918;
	Thu, 30 Apr 2026 22:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777587297; cv=none; b=dka9CwghK7ygH+y51fgp9lnh8SrbJhYjS7Fg5E3qwXfKhJLy0nt1IMfp9nFlizdT8mHPNAxWvgWwvUd3LnJdfz4BpkGEHg8HQwvjjrxwLul3BuRMmfGoUy2mI/wenvo++OTcVmR3a20kHmb6vxd8I4+Ec2oqfoDc4+zri5Cg4xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777587297; c=relaxed/simple;
	bh=L29u1QOIp8Xo/BMx2jAT7c7JuZDmOuLhk5BWSi2c2/E=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=EQjvb8Qow2jiAh1ywjra1/UXMcVLoGuipGcjGRvJGTCDdFiXvqMyJlAPQEeg8E5TZI3WdQjGIqs+Dqo/TAoqJZadeIPmm2ZueecbiIdQDISeAMcUziFPNPH7iQIPp1WvgdrYXNYEn87PuZjM8EMW6EJpNJ4co0NxlqaKlSFsbOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OkUCczH6; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OkUCczH6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=ILpjA6mJsXY1VCB+jqECM6nEqSBRFDa47SnzT/DXMlM=; b=OkUCczH6TdVKItluZCBMb1t3DZ
	gQ+X5fg7SI278JC0er9+Hlr9lK83SfyCzmMfP1KvebACpY42xetgIdGRqiHaMKlIMOLalOrNYEzJI
	Ln48jNaM+0ZXIN54ubljq2BU5dOi2dWtLu2Mc+silx5u1pWI8M7Nf2WlNKQkuFRPzKuJ+S4/9gR8C
	i6VbBbAuvszp8gdABKxqT3ni2oOFlUi4viV9kJrISeoe2AgSIziglTEfQFySlTxgn5TibLYw4OWxk
	U3WS9EgXNpDrB8WqsKmW7zLwdPW7/XbM8Er0cJ96U51858W1jy4h1fXrtvhtw7zhuf5S/CFi8KEBN
	Bw2+qk7g==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIZel-000000061lF-1Qmk;
	Thu, 30 Apr 2026 22:14:51 +0000
Message-ID: <8161ef45-be1a-41e2-a22b-a12d6b9df666@infradead.org>
Date: Thu, 30 Apr 2026 15:14:49 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] docs: watchdog: general cleaning and corrections
From: Randy Dunlap <rdunlap@infradead.org>
To: Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
Cc: Shuah Khan <skhan@linuxfoundation.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck
 <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20260228010402.2389343-1-rdunlap@infradead.org>
 <875x7cddye.fsf@trenco.lwn.net>
 <3de4c724-39bf-47f9-bf43-49552bc60a3a@infradead.org>
Content-Language: en-US
In-Reply-To: <3de4c724-39bf-47f9-bf43-49552bc60a3a@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Wim,

On 3/22/26 5:54 PM, Randy Dunlap wrote:
> 
> 
> On 3/3/26 9:23 AM, Jonathan Corbet wrote:
>> Randy Dunlap <rdunlap@infradead.org> writes:
>>
>>> Fix some obvious issues in the watchdog documentation files.
>>> I didn't try to fix every little niggling mistake.
>>>
>>>  [PATCH 1/5] docs: watchdog: mlx-wdt: small fixes
>>>  [PATCH 2/5] docs: watchdog: pcwd: fix typo and driver info.
>>>  [PATCH 3/5] docs: watchdog-api: general cleaning
>>>  [PATCH 4/5] docs: watchdog-kernel-api: general cleanups
>>>  [PATCH 5/5] docs: watchdog-parameters: add missing watchdog_core parameters
>>>
>>>  Documentation/watchdog/mlx-wdt.rst             |    4 -
>>>  Documentation/watchdog/pcwd-watchdog.rst       |   19 +++++--
>>>  Documentation/watchdog/watchdog-api.rst        |   38 +++++++--------
>>>  Documentation/watchdog/watchdog-kernel-api.rst |   20 +++++--
>>>  Documentation/watchdog/watchdog-parameters.rst |   11 +++-
>>>  5 files changed, 58 insertions(+), 34 deletions(-)
>>
>> Wim, do you want to pick these up, or should I take them through the
>> docs tree?
> 
> Wim, are you active?  Can you reply and/or merge these?

What's happening with these 5 patches?

thanks.
-- 
~Randy

