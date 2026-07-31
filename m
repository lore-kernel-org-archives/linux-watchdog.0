Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4C2489882
	for <linux-watchdog@vger.kernel.org>; Fri, 31 Jul 2026 21:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785532779; cv=none; b=JrPJJxkPaQhKJGtFY0uL/kkIyO4Vm72gYFWS6cSkaAXbWq+THjDZjgXCxHOzQnVYhvuTAuyVi/CzkQqF9fSI5nDOWWbPBqIP1k7Msg0r47e/mVA+a5UUKlJHjR8hQOoeD+mltW2nSHGBMwiWJbzR0eORofzZAvitoaYYXCdBD4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785532779; c=relaxed/simple;
	bh=Xpj4ETP7gJ6QCZ+BXwFtkWiXwC3dGDBpb8ww3Ra7HdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uTM2bFY07toU4TfwceYC4AfGQ58bdGEQqyhwngVSblLWRCrA5eq9OHP/5RY8JiDJ1odH1v7m/vQpJhvDEXltG13YSfQHo0Pq+3bz6WziyS7Fffjkd1b/p6gB/mgBVhMZd/Ittr0ebFlUPpcf0vc7Q4apf7AFxWvdzE7DnfFE/XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+cV0WqZ; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+cV0WqZ"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38e071ed6aeso1258478a91.0
        for <linux-watchdog@vger.kernel.org>; Fri, 31 Jul 2026 14:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785532777; x=1786137577; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lmYgCoGHKlqVWmNpoNo+jeEf38ARJZoemI0nl3SFw+w=;
        b=g+cV0WqZ/XbzlBx+EXzMnzas65L4JQafMsGzqj6fX8h6mpKbYYI6ePPpDMCrp/tsV9
         cb00DFcaP1xJIdwjYoWr9hX2yL4MWx/dyZ8lAQ6RQJAhSqbjtvetH039+Ysr/6qhh5xn
         CqHnWC3LWPqvIqvsC6PvGQ10gZi+93872SUuAHmOB1w9uvfd493eVtAcc+0nhEUQM0BW
         +aVoOJvs5bROYHuMKtr9gQkedQQT+6WRyH+gl4yATe++pSPGp/uW6uyrXugTy8IYuZ+b
         IWELsugKyfayFdWEFeXxkVgWJqHoaxi94OlAotsyoqIJwFCVAykurSbYN2pYyvS5tvR3
         mQjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785532777; x=1786137577;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lmYgCoGHKlqVWmNpoNo+jeEf38ARJZoemI0nl3SFw+w=;
        b=Ni1FLyYK9HjBZOH1Cy6Lfe0hy3lBdrPWVe6x78nRS03EL6F4z3HEnCsOzjCQaSf2e4
         PqLusIIZ4X8tXiIYEnqQuFT5F1iEv8BWGtGCxEqQouIhDSvip0clfMlkWGYJ9zPRUgUW
         53hzotfSqFk65GpFN+m7W7kwexdRamRaylZ30062k8B0RI/cXhvtinQ/FuDfm6NjrN7D
         TMNXShwZ+lm88w61bP5l8qATeG+Y0QizOUEuep2L4YnFmYenk1giPikifexg5jeb+QE0
         0tW9blJiMAEgdSzXFD5ZGToBupyUomRzKV8AaMiwz9L4Gvsh0939+gX2qrmZCOZs/a0u
         dLCA==
X-Forwarded-Encrypted: i=1; AHgh+RoJz67XucK898UngEKDCQAzLOELTA0hJmMIweCZItRqDE0Hv430nnugNeNwLmtd32o/lNiKc1nNfS2NHndSmw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxDNW8vWBIdcYls2Mq+paMEmDMq6452Wo3Z7B2HVKex3ji6+Tp+
	sNbnZR+2pV0/bE/9Zx4XE+IXv5OMMvgs2YeQMB+TYLeBxtvZnNl+bgZHJ7N46A==
X-Gm-Gg: AR+sD10SwFZlAdUVyNTyE2p93FvZKerhtZQLPvVjvvRu0YEZkilNSCLaq46wl22YSPo
	9mG1mXecM8KHjJtErlA/DFX9FZuK96kqao7inhj1Zj6nYcqiZU9r2xCC8sYHPhTcnS7xm9dQAGK
	tuXnP4Io7tvjjwfF7I3DifXXdduAznMIfNZX70fM4O5+4SQhXZBfuNw9TTsK3iWaiBsxRN2WRrh
	dMZzvRFurhsPmV+v6O1RBKgOIBt2gL4NMKoU5rxCgiCkDBxZPDLdLfTug05VPtsljP9r3tOoVGo
	o4RhjZn6yXBvzbNHaQQGw+vJbGRk5IgWEG5J1wqduMB138F8Ni+uo8544gxKvjIavZE6n5i/uRF
	oOLQZ0XWebpBuhZNOrLaePkowKjIaJepj1XxOJAnOiK9cREqJRGjE4ut9P2Il4BmttDFqYqI0jn
	AiP3nxUDDw2dMLpqpTlDR9z06rwQcxewe3zvJNicMQjqgPAFyFr6uziVAqpvLJ5+Jhfr1f2fA3s
	tkMsczvc00Uf6UmJC3jvncmWlXndeqHlRulKg==
X-Received: by 2002:a17:90b:5143:b0:37f:9ce2:348f with SMTP id 98e67ed59e1d1-38fbc506b07mr1121119a91.32.1785532776759;
        Fri, 31 Jul 2026 14:19:36 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e045016sm14346356eec.19.2026.07.31.14.19.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 14:19:35 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ec0a0d3c-26ff-4e37-8591-39cadfe8213e@roeck-us.net>
Date: Fri, 31 Jul 2026 14:19:33 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] watchdog: pretimeout: Allow building dump governor as
 module
To: Andrew Morton <akpm@linux-foundation.org>,
 Mayank Rungta <mrungta@google.com>
Cc: Mayank Rungta via B4 Relay <devnull+mrungta.google.com@kernel.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Tzung-Bi Shih
 <tzungbi@kernel.org>, Douglas Anderson <dianders@chromium.org>,
 linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
References: <20260730-export-cpu-backtrace-apis-v1-0-bace8e1cb817@google.com>
 <20260730155021.8252ad9d155b472702e66755@linux-foundation.org>
 <CABz7rdCZkzBv-horH0jNLeNuhCNUOaC+Ttkf_-g3CoCaCSfBbg@mail.gmail.com>
 <20260731140142.7d77cfd7e9f99f25880efd32@linux-foundation.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260731140142.7d77cfd7e9f99f25880efd32@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/31/26 14:01, Andrew Morton wrote:
> On Thu, 30 Jul 2026 16:39:14 -0700 Mayank Rungta <mrungta@google.com> wrote:
> 
>> On Thu, Jul 30, 2026 at 3:50 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>>>
>>> On Thu, 30 Jul 2026 15:00:20 -0700 Mayank Rungta via B4 Relay <devnull+mrungta.google.com@kernel.org> wrote:
>>>
>>>> All other watchdog pretimeout governors (noop, panic) can be built as
>>>> loadable modules. However the "dump" pretimeout governor is restricted
>>>> to built-in code because it calls trigger_all_cpu_backtrace(), which
>>>> relies on arch_trigger_cpumask_backtrace(), an arch specific helper that
>>>> is not exported to loadable modules.
>>>>
>>>> This 2-patch series allows building the dump governor as a module (=m):
>>>> 1) Export cpumask_backtrace() in lib/nmi_backtrace.c.
>>>> 2) Convert CONFIG_WATCHDOG_PRETIMEOUT_GOV_DUMP from bool to tristate.
>>>
>>> LGTM.  Can you please redo against current mainline?  The Kconfig has
>>> changed.
>>>
>>
>> Thanks for the LGTM!
>>
>> Regarding rebasing onto mainline (origin/master): The "dump"
>> pretimeout governor was added recently by Tzung-Bi Shih ("watchdog:
>> pretimeout: Add "dump" pretimeout governor") and is currently in
>> linux-next, so it hasn't landed in mainline tree yet.
>>
>> Because of this dependency, I based this series on linux-next so that
>> patch 2/2 ("Convert dump pretimeout governor to tristate") could apply
>> cleanly on top of the new governor.
>>
>> Please let me know what is preferred, or if you'd like me to post
>> against a different tree!
>>
> 
> Oh, OK.
> 
> Guenter, can you please process this patchset?
> 

Sure. Assuming you'd like me to handle it through the watchdog branch,
it would be great if you can send a formal Acked-by: to the first patch
of the series.

Thanks,
Guenter

