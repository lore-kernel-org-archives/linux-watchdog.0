Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA783B14A7
	for <linux-watchdog@vger.kernel.org>; Wed, 24 Jun 2026 14:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782310718; cv=none; b=nyEzBZxz/winxCjIH68bPVbgDrjsvLxRZDznf6IhNUSe2R8e9p1PYZyd7naBVO4ah7gyTukSmsPcsV6ETVC2n0QIsRgeomRH3sR/6C53LFZL8OZavhlm6Y5abf4dM50aACVBy7Iy/DXvZCLQ/tXxUyMl6e6MVDxcahbsslN0JWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782310718; c=relaxed/simple;
	bh=iO7gmX1DCKXF2Z8L/sVvXOVjNns7SLOCN13hDBVJIfs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Ap38vReSZWBvB5blCsoe6iTUfe+yL5gIIgJVekUIuUyqBagckqbMHZVb46t5t5Etajgqw2AyYgbQf5hZD7+3ERVihiCrMeCzU5m8jycqrWnNmMxMtjmCd86cOKzicjTnHPS8EyIE58UDVv+mJ6+3VpByZ7q2CXe7r44ITxWDo8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=jVlJJQMg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E4qvKizR; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="jVlJJQMg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E4qvKizR"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AC6DC7A011B;
	Wed, 24 Jun 2026 10:18:35 -0400 (EDT)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-02.internal (MEProxy); Wed, 24 Jun 2026 10:18:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1782310715;
	 x=1782397115; bh=pRNfmdzFIYEyxcxRNKFhV0lLl2b6fmqj+E+uLAkRrD0=; b=
	jVlJJQMgZBJR7rCBvbRij9KUPN/JzkebXiLAUTbqR2L3z6hH3oy7RTT7t3H5YkMw
	710qWuj5a0zAo49FJq7rm8VyTp9esCakjlOep9k5bPDOQwr8Dz5AGgQLarIgVBu7
	J+iRxmlKfuuOXZiY/x+5RgGNNZCw7i9yFiE7EnxG0vHS8jx31buOrXeWgjMdkGHH
	RbsK09mGEgAUYfk6SPoqykWKwzlHgNM1B+UKS4L+Mergw137PGf+lTwShRud/PDA
	oXb8EoPJqzmPvrBZko8hz4ub76OlJ29RrBFkaCag+Oe3kWH/omjJXX0505k5EJwC
	wKflhEXA4lstYR3YM/j9QA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782310715; x=
	1782397115; bh=pRNfmdzFIYEyxcxRNKFhV0lLl2b6fmqj+E+uLAkRrD0=; b=E
	4qvKizRFdV2eiKZJwnD4ak45tCtPlPq1RJF+MvQ3Cz9/GlvipskB5WxfaFOIWUhU
	kr6XTWzp0fbyTPSTKkKBARouJGRpsI+sqJoWB4OVY7/M4w378ODcSh0nq+TJdWkO
	fF4SLMadbJl2idUZWPiKSjX3yg3LopbDfWYfJ3dnJmu8xNRDdGFaDLSvh/HiJ4ZV
	5FkPhEQesaAjCe0K2EPYsdgkaPewWIITBoh2Jhgh+GAzy99BhVbpLwVlYfkxMNoi
	ljQm1WziTuuGXpj5Sl1ryNr7sxD8OipcZ5HB5CQ5MdZGx4nbeRjBQDsdWjMLT6kZ
	5QxhPijqO+H2rHmZgFViA==
X-ME-Sender: <xms:O-c7ai6eJbTcHUlt-1TWXA0sXE3Qx5-7sU5yl6-qkbn2CrLFHQu7BQ>
    <xme:O-c7amuBGBIafYII59lMMgHOtarPcyULVlD401eDJrw_AkgN1pfSjLkRCzzJoQoyY
    MRLg1XjtXvyQj8YGfJrNAcWPephdL0t9IetDOe0eu5N9q0O8h-F1y0>
X-ME-Proxy-Cause: dmFkZTE8oTXKo528XYJKN0NqMMN0ly7mk6Sad1m+P4mTYdrckvC7xeP+iWEoUn1bnCDsPc
    yi+kwZXOrBMfBumkSQ5GCMKJ2nm52jq+q5yluV9qgwI/IXaP+lGEiyIyytIm6x+DyIxmmq
    6jXs39+IjnooZrMKq9EUipchLCCw7IkCvrl8ojPwYZ71YLYlIDhaSmSzY3T4bnmY7fWyzc
    rcHJN8heqD1TrXvYOzXt7UnMVww3RzI/FiSgnLmDkkckBKsa7XwCsKrE2MYlPHaNnR1PDt
    Mfn2DUYq4gRloJu4qOjXv3L0t1loaR9Q22hhrhnyqSZ1ms8j2wZJcgF68GeyO5Wsau/1b5
    eT7NA+tnfLKRryQXWunjao1sVCIfLQGUKKCzdS7dckU52ISF0vwPK5SJX8IjtsMjAor9ZT
    bbr7dtCXa/czNsFgOjkea80DJjOnqBaFf6PrBFnA/V1e2Y+jfzodphooUM8LkXJTUCK38u
    7E+dU4LbDpIKab81T2fpkixCAU705etveTBnMISKdOh3Vc481VuZ7U6XPMLTGQ6vo/Mll+
    XN089zyfojCMzH2e8aD8RuevcyG+IjvJ9Hwd944ZjBV0oC1HWpbjpFiY4jkSzX+P0V/Fqu
    hv/iaecqabd8Ez9k0qmPvawuXgkDco4Ez5lrNXwDzHk/roy8Ldj6qw+LgILA
X-ME-Proxy: <xmx:O-c7aodsJmGYRgWBcrOPD_fkXpS2s3Ac5PlJxsj9J3-qRpT94DpFqA>
    <xmx:O-c7aqUA4wv0Yi2mqh6uk_i5coUQMMAlp7MWrgrFI7n8IBEHyxunCA>
    <xmx:O-c7aheOKh6xwZFiSMdAk6dK4Fx5zj09p7xZVi5bpWxJOpexpJNjbw>
    <xmx:O-c7amPqKWajIobn65aQpFuOFY_dSCt0XV-k0Ajgg68TpzDELdxufA>
    <xmx:O-c7agxoCC7Xym0WPVYTJg2-3-b-WAAhjaZ5rF65TeVdG11nd-4L0dJK>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 402B22CE409A; Wed, 24 Jun 2026 10:18:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ArMcrDYeUHoR
Date: Wed, 24 Jun 2026 10:18:14 -0400
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Guenter Roeck" <linux@roeck-us.net>, sashiko-reviews@lists.linux.dev
Cc: linux-watchdog@vger.kernel.org
Message-Id: <40b59984-9907-4391-a05d-3590402d93a2@app.fastmail.com>
In-Reply-To: <b3e11c2a-3b64-4a7a-b8f7-76773747d6a0@roeck-us.net>
References: <mpearson-lenovo@squebb.ca>
 <20260622144531.2413447-1-mpearson-lenovo@squebb.ca>
 <20260622145631.DD7041F000E9@smtp.kernel.org>
 <9e76208e-6fb7-4d62-9a49-95fc03a06737@app.fastmail.com>
 <b3e11c2a-3b64-4a7a-b8f7-76773747d6a0@roeck-us.net>
Subject: Re: [PATCH] watchdog: lenovo_se30g2_se60_wdt: Watchdog for Lenovo SE30G2 and
 SE60
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Guenter

On Tue, Jun 23, 2026, at 10:19 PM, Guenter Roeck wrote:
> On 6/22/26 08:50, Mark Pearson wrote:
>> On Mon, Jun 22, 2026, at 10:56 AM, sashiko-bot@kernel.org wrote:
>>> Thank you for your contribution! Sashiko AI review found 4 potential
>>> issue(s) to consider:
>>> - [High] The global `se_30g2_60_pdev` pointer is not cleared after
>>> being freed on the `platform_device_add()` error path, leading to a
>>> Use-After-Free and Double-Free during module exit.
>> 
>> I belive this is a valid issue - I'll fix in v2.
>> 
>>> - [High] SuperIO configuration mode is prematurely exited before
>>> reading `bram_base`, causing the read to fail and the driver to map an
>>> invalid I/O port address.
>> 
>> This one is I believe invalid and behaviour is correct. If someone wiser than me disagree's please let me know.
>> 
>
> How would anyone but you know ? Normally Super-IO access is disabled
> after the exit sequence is sent (as "lpc_write(0x2, 0x2);" in lpc_chip_id()
> seems to do). Maybe this EC is different and does not disable access to
> its IO space after "lpc_write(0x2, 0x2);". Or maybe that write does not
> disable Super-IO access at all. Again, who but you would know if the EC
> behaves differently than all the other Super-IO chips and embedded
> controllers out there ?
>
> If you say this is correct, we'll have to believe you.
>
> Thanks,
> Guenter

Yeah. I went and checked with the HW team on this one, and I've changed it.
Fix for this will be in v2 as well.

Mark
